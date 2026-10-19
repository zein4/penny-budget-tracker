-- Run once in Supabase SQL Editor. Authentication is supplied by Supabase Auth.
create table if not exists public.budgets (
  user_id uuid primary key references auth.users(id) on delete cascade,
  monthly_limit numeric(12,2) not null default 5000 check (monthly_limit > 0),
  updated_at timestamptz not null default now()
);
create table if not exists public.categories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not 
  null check (length(trim(name)) between 1 and 40),
  unique(user_id,name),
  unique(id,user_id)
);
create table if not exists public.expenses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  category_id uuid not null,
  amount numeric(12,2) not null check(amount > 0),
  description text not null default '',
  logged_at timestamptz not null default now(),
  constraint category_belongs_to_user foreign key(category_id,user_id) references public.categories(id,user_id) on delete restrict
);
create index if not exists expenses_user_date on public.expenses(user_id,logged_at desc);
alter table public.budgets enable row level security;
alter table public.categories enable row level security;
alter table public.expenses enable row level security;
create policy "own budget" on public.budgets for all to authenticated using((select auth.uid())=user_id) with check((select auth.uid())=user_id);
create policy "own categories" on public.categories for all to authenticated using((select auth.uid())=user_id) with check((select auth.uid())=user_id);
create policy "own expenses" on public.expenses for all to authenticated using((select auth.uid())=user_id) with check((select auth.uid())=user_id);
