-- ============================================================
-- REACH LEADERS SUMMIT 2026 - SUPABASE SCHEMA (FIXED)
-- Multi Ministries - Paste into Supabase SQL Editor and Run
-- ============================================================

-- Clean slate (safe to re-run)
drop table if exists registrations cascade;
drop sequence if exists reg_ref_seq cascade;

-- REGISTRATIONS TABLE
create table registrations (
  id uuid default gen_random_uuid() primary key,
  ref_number text unique,
  reg_type text not null,
  is_student boolean default false,
  first_name text not null,
  last_name text not null,
  email text not null,
  phone text not null,
  gender text,
  id_number text,
  address text,
  province text,
  ministry text,
  nok_name text,
  nok_relation text,
  nok_phone text,
  nok_email text,
  group_size integer default 1,
  group_members text,
  discount_percent integer default 0,
  children_count integer default 0,
  children_details jsonb,
  accommodation text not null,
  delegates integer default 1,
  total_amount numeric not null,
  payment_method text,
  payment_status text default 'Pending',
  payment_reference text,
  checked_in boolean default false,
  checked_in_at timestamptz,
  checked_in_by text,
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- AUTO-GENERATE REF NUMBERS: REACH-1001, REACH-1002 etc.
create sequence reg_ref_seq start 1001;

create or replace function generate_ref_number()
returns trigger as $$
begin
  if new.ref_number is null or new.ref_number = '' then
    new.ref_number := 'REACH-' || nextval('reg_ref_seq');
  end if;
  return new;
end;
$$ language plpgsql;

create trigger set_ref_number
  before insert on registrations
  for each row execute function generate_ref_number();

-- AUTO updated_at
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

-- RLS POLICIES - must be open for public registration form to work
alter table registrations enable row level security;

create policy "allow_insert" on registrations
  for insert to anon, authenticated with check (true);

create policy "allow_select" on registrations
  for select to anon, authenticated using (true);

create policy "allow_update" on registrations
  for update to anon, authenticated using (true) with check (true);

create policy "allow_delete" on registrations
  for delete to anon, authenticated using (true);

-- INDEXES for speed
create index idx_ref on registrations(ref_number);
create index idx_email on registrations(email);
create index idx_status on registrations(payment_status);
create index idx_checkin on registrations(checked_in);
create index idx_created on registrations(created_at desc);

-- DONE! Your database is ready.
