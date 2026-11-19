# Kow Hock · TikTok Margin Sheet

A spreadsheet-style page for pricing TikTok Shop products by markup on cost.
Data lives in Supabase, so every signed-in team member sees the same products and changes appear live.

Files:
- `index.html` — the whole app
- `config.js` — your Supabase URL and anon key (fill in)
- `supabase.sql` — creates the tables, security rules and live updates

## 1. Supabase (about 5 minutes)

1. Create a new project at supabase.com (region: Singapore is closest to Malaysia).
2. **SQL Editor → New query**, paste all of `supabase.sql`, click **Run**.
3. **Authentication → Sign In / Providers → Email**: turn **off** "Allow new users to sign up", so only people you add can get in.
4. **Authentication → Users → Add user**: people sign in with a username, not an email. For each person, enter
   `<username>@kowhock.local` as the email, their password (at least 6 characters), and tick "Auto confirm".
   For the admin login (username `admin`, password `989833`): email `admin@kowhock.local`, password `989833`.
5. **Project Settings → API**: copy the **Project URL** and the **anon public** key into `config.js`.

The anon key is meant to be public. The database refuses everything to anyone who isn't signed in.

## 2. GitHub Pages

1. Create a repository, e.g. `kowhock/margin-sheet`.
   GitHub Pages is free for **public** repos. That's fine here: the code is public, but your data is protected by the Supabase login.
2. Upload `index.html` and `config.js` (and this README if you like) to the `main` branch.
3. **Settings → Pages → Build and deployment**: Source = "Deploy from a branch", Branch = `main`, folder `/ (root)`. Save.
4. After a minute the site is at `https://kowhock.github.io/margin-sheet/`.
5. Optional own domain (e.g. `margin.kowhock.com`): add it under Settings → Pages → Custom domain, and add a CNAME record at your domain provider pointing to `kowhock.github.io`.

## 3. Move your products across

1. On the current Claude page, click **Export Excel**.
2. On the new site, sign in, click **Import**, pick that file, choose **Replace all rows**, click **Import**.

Products, pictures, prices and per-product percentages come across. Fee settings are already set by `supabase.sql`.

## Changing things later

- Fees: ⚙ Fee settings on the page (shared by everyone).
- New team member: Supabase → Authentication → Users → Add user (email `name@kowhock.local`, their password).
- Remove access: delete the user there.
