# Database Translation Setup Guide

This guide explains how to populate your Supabase database with content and enable multi-language support.

## 📋 Files Created

1. **`database-seed-content.sql`** - Initial content in English (projects + experiences)
2. **`database-multilanguage-setup.sql`** - Adds multi-language support (ES, FR, DE)
3. **`database-check-status.sql`** - Check database status and detect duplicates ⭐ **USE THIS FIRST**
4. **`database-fix-duplicates-complete.sql`** - Complete fix for duplicates (if detected)
5. **`database-add-experience-subtitles.sql`** - Add subtitles to experience cards (except 2026)
6. **`database-custom-subtitles-options.sql`** - Multiple subtitle style options to choose from
7. **`database-remove-duplicates.sql`** - (Older version, use #4 instead)
8. **`DATABASE_TRANSLATION_GUIDE.md`** - This guide

## 🚀 Quick Start

### Step 1: Seed the Database (English Content)

1. Go to your Supabase Dashboard
2. Navigate to **SQL Editor**
3. Create a new query
4. Copy and paste the entire contents of **`database-seed-content.sql`**
5. Click **Run** or press `Ctrl/Cmd + Enter`

This will create:
- ✅ 4 projects (Cáritas, Whirlpool, Mobile Banking, Space Game)
- ✅ 4 experience sections (2026-Present, 2025, 2024, 2023)
- ✅ Technologies and their relationships
- ✅ Skills/highlights for each experience

### Step 2: Add Multi-Language Support (Optional but Recommended)

1. In the **SQL Editor**, create another new query
2. Copy and paste the entire contents of **`database-multilanguage-setup.sql`**
3. Click **Run**

This will:
- ✅ Add language columns (`title_en`, `title_es`, `title_fr`, `title_de`, etc.)
- ✅ Populate Spanish translations
- ✅ Populate French translations
- ✅ Populate German translations
- ✅ Create helper functions for language-aware queries

## 🌍 How Language Selection Works

The frontend components now automatically fetch content based on the user's selected language:

```typescript
// When user selects language in the UI
const { language } = useTranslation() // 'en', 'es', 'fr', or 'de'

// Components fetch from database using that language
// Fallback chain: language-specific → English → default column
```

### Example Flow:

1. User selects **Spanish** (`es`) in language selector
2. Projects component fetches:
   - `title_es` if available
   - Falls back to `title_en`
   - Falls back to `title`
3. Spanish content is displayed

## 🏷️ Adding Subtitles to Experience Cards

To add subtitles to the experience cards (2025, 2024, 2023):

### Quick Add (Recommended):

1. Go to **SQL Editor**
2. Copy and paste **`database-add-experience-subtitles.sql`**
3. Click **Run**

This adds:
- **2025**: "Full-Stack Development"
- **2024**: "Systems & Architecture"  
- **2023**: "Core Programming"

### Custom Subtitles:

For more options, use **`database-custom-subtitles-options.sql`** which includes:
- **Option 1**: Technical Focus (Full-Stack Development, etc.)
- **Option 2**: Role-Based (Software Engineer, etc.)
- **Option 3**: Short & Simple (Building & Deploying, etc.)
- **Option 4**: Action-Oriented (Shipping Production Code, etc.)
- **Custom**: Write your own

Just uncomment the option you prefer and run it!

## 📝 Adding New Content

### Add a New Project:

```sql
INSERT INTO projects (
  code, 
  slug, 
  title_en,
  title_es,
  title_fr,
  title_de,
  summary_en, 
  summary_es,
  summary_fr,
  summary_de,
  featured_image_url,
  project_type_id,
  status,
  external_url,
  sort_order
) VALUES (
  'PRJ-005',
  'my-new-project',
  'My New Project',  -- English
  'Mi Nuevo Proyecto',  -- Spanish
  'Mon Nouveau Projet',  -- French
  'Mein Neues Projekt',  -- German
  'English summary...',
  'Resumen en español...',
  'Résumé en français...',
  'Deutsche Zusammenfassung...',
  '/projects/my-project.jpg',
  (SELECT id FROM project_types WHERE slug = 'web-app'),
  'active',
  'https://github.com/yourusername/project',
  5
);
```

### Add a New Experience Section:

```sql
INSERT INTO content_sections (
  key,
  title_en,
  title_es,
  title_fr,
  title_de,
  time_range,
  body_en,
  body_es,
  body_fr,
  body_de,
  status,
  sort_order
) VALUES (
  'experience_05',
  'New Role',  -- English
  'Nuevo Rol',  -- Spanish
  'Nouveau Rôle',  -- French
  'Neue Rolle',  -- German
  '2027',
  'English description...',
  'Descripción en español...',
  'Description en français...',
  'Deutsche Beschreibung...',
  'active',
  5
);
```

## 🔧 Updating Existing Content

### Update a Project:

```sql
UPDATE projects 
SET 
  title_en = 'Updated Title',
  title_es = 'Título Actualizado',
  summary_en = 'Updated summary...',
  summary_es = 'Resumen actualizado...'
WHERE code = 'PRJ-001';
```

### Update an Experience:

```sql
UPDATE content_sections 
SET 
  title_en = 'Updated Role',
  title_es = 'Rol Actualizado',
  body_en = 'Updated description...',
  body_es = 'Descripción actualizada...'
WHERE key = 'experience_01';
```

## 🎯 What's Translated

### Projects Table:
- ✅ `title` (title_en, title_es, title_fr, title_de)
- ✅ `summary` (summary_en, summary_es, summary_fr, summary_de)
- ✅ `description` (description_en, description_es, description_fr, description_de)

### Content Sections (Experiences):
- ✅ `title` (title_en, title_es, title_fr, title_de)
- ✅ `subtitle` (subtitle_en, subtitle_es, subtitle_fr, subtitle_de)
- ✅ `body` (body_en, body_es, body_fr, body_de)

### Not Translated (Static):
- ❌ `time_range` (e.g., "2026 — Present")
- ❌ `sort_order`
- ❌ `external_url`
- ❌ Image URLs
- ❌ Technology tags (shown as-is)

## 🧪 Testing Translations

### Test in SQL Editor:

```sql
-- Get projects in Spanish
SELECT 
  code,
  COALESCE(title_es, title_en, title) as title,
  COALESCE(summary_es, summary_en, summary) as summary
FROM projects 
WHERE status = 'active';

-- Get experiences in French
SELECT 
  key,
  COALESCE(title_fr, title_en, title) as title,
  COALESCE(body_fr, body_en, body) as body
FROM content_sections 
WHERE key LIKE 'experience_%';
```

### Test in the App:

1. Run your app: `npm run dev`
2. Use the language selector in the navbar
3. Switch between EN, ES, FR, DE
4. Verify projects and experience cards change language

## 🔧 Checking and Removing Duplicates

### Step 1: Check Current Status

First, check what's in your database:

1. Go to **SQL Editor** in Supabase
2. Copy and paste **`database-check-status.sql`**
3. Click **Run**

This will show you:
- 📊 All projects and content sections
- 🔍 Duplicate detection report
- ✅ Summary with recommendations

### Step 2: Remove Duplicates (If Needed)

If the status check shows duplicates:

1. In **SQL Editor**, create a new query
2. Copy and paste **`database-fix-duplicates-complete.sql`**
3. Click **Run**

This comprehensive script will:
- ✅ Show duplicates BEFORE cleanup
- ✅ Delete child relationships first (safe order)
- ✅ Remove duplicate projects (keeps first by `code`)
- ✅ Remove duplicate experiences (keeps first by `key`)
- ✅ Remove duplicate technologies
- ✅ Clean up orphaned relationships
- ✅ Show verification counts AFTER cleanup
- ✅ List all remaining records

After running, you should see:
- **4 unique projects** (PRJ-001 through PRJ-004)
- **4 unique experiences** (experience_01 through experience_04)
- No duplicate entries in any table
- Complete before/after comparison

## 🐛 Troubleshooting

### Problem: Content not changing language

**Solution**: Make sure you ran the multi-language setup script and the language columns exist:

```sql
-- Check if columns exist
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'projects' 
  AND column_name LIKE '%_es';
```

### Problem: Content shows as empty

**Solution**: Check if translations are populated:

```sql
-- Check Spanish translations
SELECT code, title_es, summary_es 
FROM projects 
WHERE code = 'PRJ-001';
```

### Problem: Still seeing "Supabase not configured" error

**Solution**: The Supabase credentials are already hardcoded in `lib/supabase.ts`. If you still see errors:

1. Check your Supabase project is running
2. Verify the URL and anon key are correct
3. Check browser console for specific errors

## 📚 Additional Resources

- [Supabase SQL Editor](https://supabase.com/docs/guides/database/overview)
- [PostgreSQL Functions](https://www.postgresql.org/docs/current/functions.html)
- Translation values are based on your existing `lib/translations.tsx` file

## ✅ Verification Checklist

After running both scripts, verify:

- [ ] Projects table has 4 entries
- [ ] Projects have English content in `title_en`, `summary_en`
- [ ] Projects have Spanish content in `title_es`, `summary_es`
- [ ] Content_sections table has 4 entries (experience_01 through experience_04)
- [ ] Content_sections have translations in all languages
- [ ] Section_highlights table has skill entries for each experience
- [ ] Technologies table is populated
- [ ] Project_technologies relationships are created
- [ ] Language selector in app switches content

## 🎉 You're Done!

Your portfolio now has:
- ✅ Database-driven content (no hardcoded data)
- ✅ Multi-language support (EN, ES, FR, DE)
- ✅ Automatic language switching
- ✅ Easy content management via Supabase Dashboard

To add more content or translations, just use SQL or the Supabase Table Editor!
