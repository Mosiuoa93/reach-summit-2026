# REACH Leaders Summit 2026 — Deployment Guide
## Multi Ministries

---

## What's in this folder

| File | Purpose |
|------|---------|
| `index.html` | Public registration app |
| `admin.html` | Admin dashboard (password protected) |
| `schema.sql` | Supabase database setup |
| `logo.jpg` | Multi Ministries logo |
| `README.md` | This guide |

---

## STEP 1 — Set up the Supabase database

1. Go to **https://supabase.com** and open your `reach-summit-2026` project
2. In the left menu click **SQL Editor**
3. Click **New Query**
4. Open the `schema.sql` file from this folder and paste the entire contents
5. Click **Run** (green button)
6. You should see "Success" — your database is ready

---

## STEP 2 — Deploy to GitHub Pages (FREE)

### 2a. Create a GitHub account
- Go to **https://github.com** and sign up (free)

### 2b. Create a new repository
1. Click the **+** icon → **New repository**
2. Name it: `reach-summit-2026`
3. Set to **Public**
4. Click **Create repository**

### 2c. Upload your files
1. Click **uploading an existing file** link on the new repo page
2. Drag and drop ALL files from this folder:
   - `index.html`
   - `admin.html`
   - `schema.sql`
   - `logo.jpg`
3. Scroll down, click **Commit changes**

### 2d. Enable GitHub Pages
1. Go to **Settings** tab in your repository
2. Scroll to **Pages** section in the left menu
3. Under **Source** → select **Deploy from a branch**
4. Branch: **main** · Folder: **/ (root)**
5. Click **Save**
6. Wait 2-3 minutes
7. Your site will be live at: `https://YOUR-GITHUB-USERNAME.github.io/reach-summit-2026/`

---

## STEP 3 — Connect your domain (reach-summit.co.za)

### In GitHub Pages Settings:
1. In the **Pages** settings, under **Custom domain**
2. Type: `reach-summit.co.za`
3. Click **Save**

### In your domain registrar (where you bought reach-summit.co.za):
Add these DNS records:

**A Records** (point to GitHub):
```
@ → 185.199.108.153
@ → 185.199.109.153
@ → 185.199.110.153
@ → 185.199.111.153
```

**CNAME Record**:
```
www → YOUR-GITHUB-USERNAME.github.io
```

DNS changes take up to 24 hours to propagate.

---

## STEP 4 — Admin access

**Admin URL:** `https://reach-summit.co.za/admin.html`

**Password:** `MultiMin@2026`

To change the password:
- Open `admin.html` in a text editor
- Find the line: `const ADMIN_PASSWORD = 'MultiMin@2026';`
- Change to your preferred password
- Re-upload `admin.html` to GitHub

---

## Admin Features

| Feature | How to use |
|---------|-----------|
| View all registrations | Admin dashboard → All Registrations tab |
| Check in delegates | Admin → Check-In tab → click "Check In" button |
| Update payment status | Click "Edit" on any registration |
| Export to CSV | Click "Export CSV ↓" button (downloads with today's date) |
| Print list | Click "Print ↓" button |
| Search delegates | Use search box in any tab |
| View full details | Click "View" on any registration |
| Delete registration | Click "Del" (asks for confirmation) |

---

## Registration Features

| Feature | Detail |
|---------|--------|
| Individual registration | Personal details, next of kin, accommodation |
| Group registration | Ministry info, group list, automatic discounts |
| Couple registration | Joint booking + children under 14 |
| Student discount | R1,300 dormitory (standard R1,650) |
| Group discounts | 10 = 10%, 20 = 20%, 30+ = 30% off |
| PayFast payment | Opens payment.payfast.io link |
| Pay at venue | Confirmation shown on screen |
| Reference numbers | Auto-generated: REACH-1001, REACH-1002, etc. |

---

## Accommodation Capacity

| Type | Rate | Max People | Notes |
|------|------|-----------|-------|
| Dormitory | R1,650 | 300 | Individuals only. Students R1,300 |
| Couples Room | R3,000 | No limit set | + R1,300 per child under 14 |
| Guest House | R1,900 | 120 | |

---

## Cost Summary (Monthly)

| Service | Cost |
|---------|------|
| GitHub Pages | FREE |
| Supabase (free tier) | FREE |
| Your domain (reach-summit.co.za) | Already owned |
| **Total** | **R0/month** |

---

## Keeping Supabase active

Supabase free tier pauses after **7 days of inactivity**.
To prevent this: visit `https://reach-summit.co.za` at least once a week,
OR upgrade to Supabase Pro (~$25/month) closer to the event for guaranteed uptime.

**Recommended:** 4 weeks before the event (around 3 August 2026), check that the Supabase project is active.

---

## Support

Multi Ministries · office@multiministries.co.za  
www.multiministries.co.za  
5 Limpopo Avenue, Musina, Limpopo 0900
