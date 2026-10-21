-- AutoDrive + Supabase Auth

create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  name text,
  role text default 'viewer',
  app_data jsonb not null default '{}'::jsonb,
  created_at timestamptz default now()
);

create table if not exists public.docs (
  col text not null,
  id text not null,
  data jsonb not null,
  updated_at timestamptz default now(),
  primary key (col, id)
);

create index if not exists idx_docs_col on public.docs (col);

alter table public.profiles enable row level security;
alter table public.docs enable row level security;

revoke all on public.profiles from anon;
grant select, update on public.profiles to authenticated;

create policy "Users can read own profile"
  on public.profiles for select to authenticated
  using ((select auth.uid()) = id);

create policy "Users can update own profile"
  on public.profiles for update to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

create policy "Authenticated users can read docs"
  on public.docs for select to authenticated using (true);

create policy "Authenticated users can write docs"
  on public.docs for all to authenticated using (true) with check (true);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, name, role, app_data)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name', split_part(coalesce(new.email, 'user'), '@', 1)),
    'viewer',
    jsonb_build_object(
      'username', coalesce(new.email, ''),
      'userType', 'staff',
      'isOwner', false,
      'canEdit', false,
      'perms', jsonb_build_array('home','cars','book','cust')
    )
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();

alter publication supabase_realtime add table public.docs;
