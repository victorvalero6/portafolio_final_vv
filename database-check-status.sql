-- ============================================
-- CHECK DATABASE STATUS
-- ============================================
-- Run this to see what's currently in your database
-- ============================================

SELECT '=== DATABASE STATUS REPORT ===' as report;

-- ============================================
-- PROJECTS
-- ============================================
SELECT '--- PROJECTS ---' as section;

-- Show all projects
SELECT 
  id,
  code,
  COALESCE(title_en, title) as title,
  sort_order,
  status
FROM projects
ORDER BY id;

-- Count projects by code
SELECT 
  '>> Projects by Code:' as info,
  code,
  COUNT(*) as count
FROM projects
GROUP BY code
ORDER BY code;

-- Total projects
SELECT '>> Total Projects:' as info, COUNT(*) as total FROM projects;


-- ============================================
-- CONTENT SECTIONS (EXPERIENCES)
-- ============================================
SELECT '--- CONTENT SECTIONS ---' as section;

-- Show all experience sections
SELECT 
  id,
  key,
  COALESCE(title_en, title) as title,
  time_range,
  sort_order,
  status
FROM content_sections
WHERE key LIKE 'experience_%'
ORDER BY id;

-- Count content sections by key
SELECT 
  '>> Content Sections by Key:' as info,
  key,
  COUNT(*) as count
FROM content_sections
WHERE key LIKE 'experience_%'
GROUP BY key
ORDER BY key;

-- Total content sections
SELECT '>> Total Content Sections:' as info, COUNT(*) as total 
FROM content_sections 
WHERE key LIKE 'experience_%';


-- ============================================
-- TECHNOLOGIES
-- ============================================
SELECT '--- TECHNOLOGIES ---' as section;

SELECT 
  '>> Technologies by Slug:' as info,
  slug,
  name,
  COUNT(*) as count
FROM technologies
GROUP BY slug, name
HAVING COUNT(*) > 1;

SELECT '>> Total Technologies:' as info, COUNT(*) as total FROM technologies;


-- ============================================
-- SECTION HIGHLIGHTS
-- ============================================
SELECT '--- SECTION HIGHLIGHTS ---' as section;

SELECT '>> Total Section Highlights:' as info, COUNT(*) as total FROM section_highlights;

-- Highlights per section
SELECT 
  '>> Highlights per Section:' as info,
  cs.key,
  COUNT(sh.id) as highlight_count
FROM content_sections cs
LEFT JOIN section_highlights sh ON cs.id = sh.content_section_id
WHERE cs.key LIKE 'experience_%'
GROUP BY cs.key
ORDER BY cs.key;


-- ============================================
-- PROJECT TECHNOLOGIES
-- ============================================
SELECT '--- PROJECT TECHNOLOGIES ---' as section;

SELECT '>> Total Project-Technology Links:' as info, COUNT(*) as total FROM project_technologies;

-- Technologies per project
SELECT 
  '>> Technologies per Project:' as info,
  p.code,
  COUNT(pt.technology_id) as tech_count
FROM projects p
LEFT JOIN project_technologies pt ON p.id = pt.project_id
GROUP BY p.code
ORDER BY p.code;


-- ============================================
-- DUPLICATES DETECTION
-- ============================================
SELECT '=== DUPLICATES DETECTED ===' as section;

-- Duplicate projects
SELECT '>> Duplicate Projects (by code):' as warning;
SELECT code, COUNT(*) as duplicate_count
FROM projects
GROUP BY code
HAVING COUNT(*) > 1;

-- Duplicate content sections
SELECT '>> Duplicate Content Sections (by key):' as warning;
SELECT key, COUNT(*) as duplicate_count
FROM content_sections
GROUP BY key
HAVING COUNT(*) > 1;

-- Duplicate technologies
SELECT '>> Duplicate Technologies (by slug):' as warning;
SELECT slug, COUNT(*) as duplicate_count
FROM technologies
GROUP BY slug
HAVING COUNT(*) > 1;


-- ============================================
-- SUMMARY
-- ============================================
SELECT '=== SUMMARY ===' as section;

SELECT 
  'Projects' as table_name,
  COUNT(*) as total_records,
  COUNT(DISTINCT code) as unique_records,
  CASE WHEN COUNT(*) = COUNT(DISTINCT code) THEN '✅ No duplicates' ELSE '⚠️ HAS DUPLICATES' END as status
FROM projects

UNION ALL

SELECT 
  'Content Sections' as table_name,
  COUNT(*) as total_records,
  COUNT(DISTINCT key) as unique_records,
  CASE WHEN COUNT(*) = COUNT(DISTINCT key) THEN '✅ No duplicates' ELSE '⚠️ HAS DUPLICATES' END as status
FROM content_sections
WHERE key LIKE 'experience_%'

UNION ALL

SELECT 
  'Technologies' as table_name,
  COUNT(*) as total_records,
  COUNT(DISTINCT slug) as unique_records,
  CASE WHEN COUNT(*) = COUNT(DISTINCT slug) THEN '✅ No duplicates' ELSE '⚠️ HAS DUPLICATES' END as status
FROM technologies;


-- ============================================
-- RECOMMENDATIONS
-- ============================================
SELECT '=== RECOMMENDATIONS ===' as section;

SELECT 
  CASE 
    WHEN EXISTS (SELECT 1 FROM projects GROUP BY code HAVING COUNT(*) > 1)
      OR EXISTS (SELECT 1 FROM content_sections GROUP BY key HAVING COUNT(*) > 1)
      OR EXISTS (SELECT 1 FROM technologies GROUP BY slug HAVING COUNT(*) > 1)
    THEN '⚠️ DUPLICATES FOUND! Run database-fix-duplicates-complete.sql to clean up'
    ELSE '✅ No duplicates detected. Database looks good!'
  END as recommendation;
