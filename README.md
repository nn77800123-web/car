# AUTODRIVE — Supabase connected build

This package is configured for the connected Supabase project.

- Project URL: `https://wuhrxoezcuxykpubldqp.supabase.co`
- Client key: Supabase publishable key (safe for browser client use)
- Database: `public.profiles`, `public.docs`
- Storage bucket: `photos` (private)
- Realtime: `public.docs`
- RLS: enabled on application tables

## Run

Open `autodrive-supabase.html` in a modern browser.

Create the first Supabase Auth user. The first registered user becomes `owner`; later users become `contributor`.

## Security

Do not put a Supabase secret/service-role key in the HTML. Browser access uses the publishable key and is protected by Auth + RLS.

The SQL in `schema.sql` is the hardened version applied to the connected project.
