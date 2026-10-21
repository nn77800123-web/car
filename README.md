# AutoDrive — GitHub Pages + Supabase Auth + Database

## Supabase
- Project: `car`
- URL: `https://wuhrxoezcuxykpubldqp.supabase.co`
- Browser uses the Supabase publishable key only.
- Login uses **Supabase Auth (email + password)**.
- User profiles are stored in `public.profiles`.
- Application data is stored in `public.docs`.
- Supabase Realtime is enabled for `docs`.

## Important
1. Create the first account from the website using **إنشاء حساب جديد**, or create it from Supabase Authentication.
2. New accounts are created as `viewer` by default.
3. To make an account the system administrator, update its row in `public.profiles` and set `role` to `admin`.
4. Email confirmation may be required depending on the project's Supabase Auth settings.
5. Do not put a `service_role`/secret key in GitHub Pages.

## GitHub Pages
Upload the contents of this folder to the root of the `car` repository. `index.html` must be in the repository root.
