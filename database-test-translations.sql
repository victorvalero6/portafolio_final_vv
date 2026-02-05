-- ============================================
-- TEST TRANSLATIONS IN DATABASE
-- ============================================
-- Run this to verify translations are correctly stored
-- ============================================

SELECT '=== PROJECTS TRANSLATIONS TEST ===' as test_section;

-- Check if translation columns exist in projects
SELECT 
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'projects'
  AND column_name LIKE '%_en' OR column_name LIKE '%_es' OR column_name LIKE '%_fr' OR column_name LIKE '%_de'
ORDER BY column_name;

-- Show first project in all languages
SELECT 
  code,
  'EN' as lang,
  COALESCE(title_en, title) as title,
  COALESCE(summary_en, summary) as summary
FROM projects
WHERE code = 'PRJ-001'
UNION ALL
SELECT 
  code,
  'ES' as lang,
  COALESCE(title_es, title) as title,
  COALESCE(summary_es, summary) as summary
FROM projects
WHERE code = 'PRJ-001'
UNION ALL
SELECT 
  code,
  'FR' as lang,
  COALESCE(title_fr, title) as title,
  COALESCE(summary_fr, summary) as summary
FROM projects
WHERE code = 'PRJ-001'
UNION ALL
SELECT 
  code,
  'DE' as lang,
  COALESCE(title_de, title) as title,
  COALESCE(summary_de, summary) as summary
FROM projects
WHERE code = 'PRJ-001';


SELECT '=== CONTENT SECTIONS TRANSLATIONS TEST ===' as test_section;

-- Check if translation columns exist in content_sections
SELECT 
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'content_sections'
  AND (column_name LIKE '%_en' OR column_name LIKE '%_es' OR column_name LIKE '%_fr' OR column_name LIKE '%_de')
ORDER BY column_name;

-- Show first experience in all languages
SELECT 
  key,
  'EN' as lang,
  COALESCE(title_en, title) as title,
  COALESCE(subtitle_en, subtitle) as subtitle
FROM content_sections
WHERE key = 'experience_01'
UNION ALL
SELECT 
  key,
  'ES' as lang,
  COALESCE(title_es, title) as title,
  COALESCE(subtitle_es, subtitle) as subtitle
FROM content_sections
WHERE key = 'experience_01'
UNION ALL
SELECT 
  key,
  'FR' as lang,
  COALESCE(title_fr, title) as title,
  COALESCE(subtitle_fr, subtitle) as subtitle
FROM content_sections
WHERE key = 'experience_01'
UNION ALL
SELECT 
  key,
  'DE' as lang,
  COALESCE(title_de, title) as title,
  COALESCE(subtitle_de, subtitle) as subtitle
FROM content_sections
WHERE key = 'experience_01';


SELECT '=== SUMMARY ===' as test_section;

-- Count non-null translations for projects
SELECT 
  'Projects with EN translations' as metric,
  COUNT(*) as count
FROM projects
WHERE title_en IS NOT NULL
UNION ALL
SELECT 
  'Projects with ES translations' as metric,
  COUNT(*) as count
FROM projects
WHERE title_es IS NOT NULL
UNION ALL
SELECT 
  'Projects with FR translations' as metric,
  COUNT(*) as count
FROM projects
WHERE title_fr IS NOT NULL
UNION ALL
SELECT 
  'Projects with DE translations' as metric,
  COUNT(*) as count
FROM projects
WHERE title_de IS NOT NULL;

-- Count non-null translations for content_sections
SELECT 
  'Experiences with EN translations' as metric,
  COUNT(*) as count
FROM content_sections
WHERE key LIKE 'experience_%' AND title_en IS NOT NULL
UNION ALL
SELECT 
  'Experiences with ES translations' as metric,
  COUNT(*) as count
FROM content_sections
WHERE key LIKE 'experience_%' AND title_es IS NOT NULL
UNION ALL
SELECT 
  'Experiences with FR translations' as metric,
  COUNT(*) as count
FROM content_sections
WHERE key LIKE 'experience_%' AND title_fr IS NOT NULL
UNION ALL
SELECT 
  'Experiences with DE translations' as metric,
  COUNT(*) as count
FROM content_sections
WHERE key LIKE 'experience_%' AND title_de IS NOT NULL;


SELECT '=== RECOMMENDATIONS ===' as test_section;

SELECT 
  CASE 
    WHEN EXISTS (
      SELECT 1 FROM projects WHERE title_es IS NULL OR title_fr IS NULL OR title_de IS NULL
    ) THEN '⚠️ Some projects are missing translations. Run database-multilanguage-setup.sql'
    WHEN EXISTS (
      SELECT 1 FROM content_sections 
      WHERE key LIKE 'experience_%' AND (title_es IS NULL OR title_fr IS NULL OR title_de IS NULL)
    ) THEN '⚠️ Some experiences are missing translations. Run database-recreate-experience-cards.sql'
    ELSE '✅ All translations look good! If not showing in UI, check browser console for errors.'
  END as recommendation;
