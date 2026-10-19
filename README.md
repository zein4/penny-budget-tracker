# P.E.N.N.Y. – Personal Budget Tracker

Responsive Next.js + TypeScript + Supabase web app based on the provided mobile wireframes. Includes authenticated accounts, monthly budget limit, category management, add/edit/delete expenses, searchable expense list, budget alerts, and a chart-style category breakdown.

## Setup (VS Code)
1. Install Node.js 20+.
2. Create a Supabase project at https://supabase.com/dashboard.
3. In **SQL Editor**, run `supabase/schema.sql`. It creates database tables, checks, foreign keys, and per-user Row Level Security policies.
4. In **Authentication > Providers > Email**, enable Email authentication. For a classroom demo, configure the email confirmation setting according to your testing needs.
5. Under **Project Settings > API**, copy the Project URL and public `anon` / publishable API key. **Do not use a secret/service_role key in the browser.**
6. Copy `.env.example` to `.env.local` and fill the two public variables.
7. Run `npm install` then `npm run dev` and visit http://localhost:3000.
8. Create an account, sign in, and click **Create starter categories**. Set the budget under Settings. Then add expenses.

## Vercel public link
1. Push the project folder to a GitHub repository (do not commit `.env.local`).
2. In https://vercel.com/new, import the GitHub repository.
3. Set the same `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` in the Vercel project's **Environment Variables**.
4. Deploy. Vercel will provide a public `https://<your-project>.vercel.app` link. This ZIP does not contain a live deployment; deployment requires the user's Vercel account.
5. In Supabase **Authentication > URL Configuration**, set the site URL to the Vercel domain and add any needed redirect URLs (for email confirmation).

## Architecture
Presentation = Next.js React components (`app/page.tsx`, CSS). Controller = form/event handlers that validate inputs and call data functions. Business rules = positive amounts, required categories, future-date restriction, calculated monthly spending. Persistence = Supabase PostgreSQL tables with RLS policies. Supabase Auth manages sessions and private user IDs.

## Important behavior
- Data is stored in Supabase **only after** configuring environment variables and running the SQL. There is no fake local-storage fallback.
- Users can view only their own expense/category/budget rows through RLS.
- Budget alerts appear after save, particularly relevant once 80% is used. Calculations use the logged expense date and current month.
- Since the original P.E.N.N.Y. Mini-SRS was not among the attached files, requirement IDs in the accompanying report use the available P.E.N.N.Y. Activity 3 documents; verify against the original Mini-SRS before final submission.
