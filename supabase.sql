-- Kow Hock · TikTok Margin Sheet — Supabase setup
-- Run once in Supabase: SQL Editor → New query → paste → Run.

create table if not exists public.products (
  id         text primary key,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

create table if not exists public.settings (
  id         text primary key,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

-- Only signed-in team members can read or change anything.
alter table public.products enable row level security;
alter table public.settings enable row level security;

drop policy if exists "team can do everything" on public.products;
create policy "team can do everything" on public.products
  for all to authenticated using (true) with check (true);

drop policy if exists "team can do everything" on public.settings;
create policy "team can do everything" on public.settings
  for all to authenticated using (true) with check (true);

-- Live updates: changes show up for everyone without refreshing.
alter publication supabase_realtime add table public.products;
alter publication supabase_realtime add table public.settings;

-- Your current fee settings, copied from the Claude page on 19 Nov 2026.
insert into public.settings (id, data) values ('main', '{
  "markup": 5, "txn": 4.01, "comm": 13.5, "bxp": 4.86, "vxp": 0,
  "aff": 7.2, "flat": 0, "shipPct": 0.43, "custShip": 0, "defMargin": 0
}'::jsonb)
on conflict (id) do nothing;
