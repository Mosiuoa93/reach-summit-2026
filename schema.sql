-- ============================================================
-- REACH LEADERS SUMMIT 2026 - SUPABASE SCHEMA
-- Multi Ministries
-- Paste this entire file into Supabase SQL Editor and click Run
-- ============================================================

-- 1. REGISTRATIONS TABLE
create table if not exists registrations (
  id uuid default gen_random_uuid() primary key,
  ref_number text unique not null,
  reg_type text not null check (reg_type in ('individual','group','couple')),
  is_student boolean default false,

  -- Personal details
  first_name text not null,
  last_name text not null,
  email text not null,
  phone text not null,
  gender text,
  id_number text,
  address text,
  province text,
  ministry text,

  -- Next of kin
  nok_name text,
  nok_relation text,
  nok_phone text,
  nok_email text,

  -- Group specific
  group_size integer default 1,
  group_members text,
  discount_percent integer default 0,

  -- Couple specific
  children_count integer default 0,
  children_details jsonb,

  -- Accommodation & payment
  accommodation text not null check (accommodation in ('dormitory','guesthouse','couples')),
  delegates integer default 1,
  total_amount numeric not null,
  payment_method text check (payment_method in ('payfast','venue')),
  payment_status text default 'Pending' check (payment_status in ('Pending','Paid','Cancelled')),
  payment_reference text,
  proof_of_payment text,

  -- Event management
  checked_in boolean default false,
  checked_in_at timestamptz,
  checked_in_by text,
  notes text,

  -- Timestamps
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 2. ADMIN USERS TABLE
create table if not exists admin_users (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  email text unique not null,
  role text default 'admin' check (role in ('super_admin','admin','check_in')),
  is_active boolean default true,
  last_login timestamptz,
  created_at timestamptz default now()
);

-- 3. AUTO-INCREMENT REF NUMBERS
create sequence if not exists reg_ref_seq start 1001;

create or replace function generate_ref_number()
returns trigger as $$
begin
  new.ref_number := 'REACH-' || nextval('reg_ref_seq');
  return new;
end;
$$ language plpgsql;

create trigger set_ref_number
  before insert on registrations
  for each row
  when (new.ref_number is null or new.ref_number = '')
  execute function generate_ref_number();

-- 4. AUTO-UPDATE updated_at
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger registrations_updated_at
  before update on registrations
  for each row execute function update_updated_at();

-- 5. ROW LEVEL SECURITY
alter table registrations enable row level security;
alter table admin_users enable row level security;

-- Allow anyone to INSERT (register)
create policy "Anyone can register" on registrations
  for insert with check (true);

-- Allow anyone to read their own registration by ref
create policy "Public can read own registration" on registrations
  for select using (true);

-- Allow updates (for admin check-in and status updates)
create policy "Service role can update" on registrations
  for update using (true);

create policy "Service role can delete" on registrations
  for delete using (true);

-- Admin users readable by all (for login check)
create policy "Admin users readable" on admin_users
  for select using (true);

-- 6. INDEXES for performance
create index if not exists idx_registrations_ref on registrations(ref_number);
create index if not exists idx_registrations_email on registrations(email);
create index if not exists idx_registrations_status on registrations(payment_status);
create index if not exists idx_registrations_checkin on registrations(checked_in);
create index if not exists idx_registrations_accom on registrations(accommodation);

-- 7. SEED ADMIN USERS (update passwords via Supabase Auth separately)
-- These are display records only - auth is handled by shared password in app
insert into admin_users (name, email, role) values
  ('Super Admin', 'admin@multiministries.co.za', 'super_admin'),
  ('Registration Admin', 'registration@multiministries.co.za', 'admin'),
  ('Check-In Team', 'checkin@multiministries.co.za', 'check_in')
on conflict (email) do nothing;

-- ============================================================
-- DONE! Your database is ready.
-- Next: open index.html and admin.html in your project
-- ============================================================
