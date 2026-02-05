-- ============================================
-- COMPLETE FIX FOR DUPLICATES
-- ============================================
-- This script will:
-- 1. Show current duplicates
-- 2. Remove child relationships first
-- 3. Remove parent duplicates
-- 4. Verify cleanup
-- ============================================

-- ============================================
-- STEP 1: VERIFY CURRENT DUPLICATES
-- ============================================

SELECT '=== BEFORE CLEANUP ===' as status;

-- Show duplicate projects
SELECT 'Duplicate Projects:' as info;
SELECT code, title, COUNT(*) as count
FROM projects
GROUP BY code, title
HAVING COUNT(*) > 1;

-- Show all projects count
SELECT 'Total Projects:' as info, COUNT(*) as count FROM projects;

-- Show duplicate content sections
SELECT 'Duplicate Content Sections:' as info;
SELECT key, title, COUNT(*) as count
FROM content_sections
GROUP BY key, title
HAVING COUNT(*) > 1;

-- Show all content sections count
SELECT 'Total Content Sections:' as info, COUNT(*) as count FROM content_sections;


-- ============================================
-- STEP 2: DELETE CHILD RECORDS FIRST
-- ============================================

-- Get IDs of duplicate projects (keep oldest, delete newer)
WITH duplicate_projects AS (
  SELECT 
    id,
    code,
    ROW_NUMBER() OVER (PARTITION BY code ORDER BY id ASC) as rn
  FROM projects
),
ids_to_delete AS (
  SELECT id FROM duplicate_projects WHERE rn > 1
)
-- Delete project_technologies for duplicate projects
DELETE FROM project_technologies
WHERE project_id IN (SELECT id FROM ids_to_delete);

-- Get IDs of duplicate content sections (keep oldest, delete newer)
WITH duplicate_sections AS (
  SELECT 
    id,
    key,
    ROW_NUMBER() OVER (PARTITION BY key ORDER BY id ASC) as rn
  FROM content_sections
),
section_ids_to_delete AS (
  SELECT id FROM duplicate_sections WHERE rn > 1
)
-- Delete section_highlights for duplicate sections
DELETE FROM section_highlights
WHERE content_section_id IN (SELECT id FROM section_ids_to_delete);

-- Delete content_section_tags for duplicate sections
WITH duplicate_sections AS (
  SELECT 
    id,
    key,
    ROW_NUMBER() OVER (PARTITION BY key ORDER BY id ASC) as rn
  FROM content_sections
),
section_ids_to_delete AS (
  SELECT id FROM duplicate_sections WHERE rn > 1
)
DELETE FROM content_section_tags
WHERE content_section_id IN (SELECT id FROM section_ids_to_delete);


-- ============================================
-- STEP 3: DELETE PARENT DUPLICATES
-- ============================================

-- Delete duplicate projects (keep first by id)
WITH duplicate_projects AS (
  SELECT 
    id,
    code,
    ROW_NUMBER() OVER (PARTITION BY code ORDER BY id ASC) as rn
  FROM projects
)
DELETE FROM projects
WHERE id IN (
  SELECT id FROM duplicate_projects WHERE rn > 1
);

-- Delete duplicate content sections (keep first by id)
WITH duplicate_sections AS (
  SELECT 
    id,
    key,
    ROW_NUMBER() OVER (PARTITION BY key ORDER BY id ASC) as rn
  FROM content_sections
)
DELETE FROM content_sections
WHERE id IN (
  SELECT id FROM duplicate_sections WHERE rn > 1
);

-- Delete duplicate technologies (keep first by slug)
WITH duplicate_techs AS (
  SELECT 
    id,
    slug,
    ROW_NUMBER() OVER (PARTITION BY slug ORDER BY id ASC) as rn
  FROM technologies
)
DELETE FROM technologies
WHERE id IN (
  SELECT id FROM duplicate_techs WHERE rn > 1
);

-- Delete duplicate section_tags (keep first by slug)
WITH duplicate_tags AS (
  SELECT 
    id,
    slug,
    ROW_NUMBER() OVER (PARTITION BY slug ORDER BY id ASC) as rn
  FROM section_tags
)
DELETE FROM section_tags
WHERE id IN (
  SELECT id FROM duplicate_tags WHERE rn > 1
);

-- Delete duplicate project_types (keep first by slug)
WITH duplicate_types AS (
  SELECT 
    id,
    slug,
    ROW_NUMBER() OVER (PARTITION BY slug ORDER BY id ASC) as rn
  FROM project_types
)
DELETE FROM project_types
WHERE id IN (
  SELECT id FROM duplicate_types WHERE rn > 1
);

-- Delete duplicate photo_albums (keep first by key)
WITH duplicate_albums AS (
  SELECT 
    id,
    key,
    ROW_NUMBER() OVER (PARTITION BY key ORDER BY id ASC) as rn
  FROM photo_albums
)
DELETE FROM photo_albums
WHERE id IN (
  SELECT id FROM duplicate_albums WHERE rn > 1
);


-- ============================================
-- STEP 4: CLEAN UP ORPHANED RELATIONSHIPS
-- ============================================

-- Remove project_technologies that point to non-existent projects
DELETE FROM project_technologies
WHERE project_id NOT IN (SELECT id FROM projects);

-- Remove project_technologies that point to non-existent technologies
DELETE FROM project_technologies
WHERE technology_id NOT IN (SELECT id FROM technologies);

-- Remove section_highlights that point to non-existent content_sections
DELETE FROM section_highlights
WHERE content_section_id NOT IN (SELECT id FROM content_sections);

-- Remove content_section_tags that point to non-existent content_sections
DELETE FROM content_section_tags
WHERE content_section_id NOT IN (SELECT id FROM content_sections);

-- Remove content_section_tags that point to non-existent section_tags
DELETE FROM content_section_tags
WHERE section_tag_id NOT IN (SELECT id FROM section_tags);

-- Remove photos that point to non-existent albums
DELETE FROM photos
WHERE album_id NOT IN (SELECT id FROM photo_albums);


-- ============================================
-- STEP 5: VERIFY CLEANUP
-- ============================================

SELECT '=== AFTER CLEANUP ===' as status;

-- Check for remaining duplicates in projects
SELECT 'Remaining Duplicate Projects:' as info;
SELECT code, title, COUNT(*) as count
FROM projects
GROUP BY code, title
HAVING COUNT(*) > 1;

-- Show final projects
SELECT 'Final Projects List:' as info;
SELECT id, code, title_en, sort_order 
FROM projects 
ORDER BY sort_order;

-- Count projects
SELECT 'Total Projects:' as info, COUNT(*) as count FROM projects;

-- Check for remaining duplicates in content_sections
SELECT 'Remaining Duplicate Content Sections:' as info;
SELECT key, title, COUNT(*) as count
FROM content_sections
GROUP BY key, title
HAVING COUNT(*) > 1;

-- Show final content sections
SELECT 'Final Content Sections List:' as info;
SELECT id, key, title_en, sort_order 
FROM content_sections 
WHERE key LIKE 'experience_%'
ORDER BY sort_order;

-- Count content sections
SELECT 'Total Content Sections:' as info, COUNT(*) as count FROM content_sections WHERE key LIKE 'experience_%';

-- Count all tables
SELECT 'Technologies:' as table_name, COUNT(*) as count FROM technologies
UNION ALL
SELECT 'Section Tags:' as table_name, COUNT(*) as count FROM section_tags
UNION ALL
SELECT 'Project Types:' as table_name, COUNT(*) as count FROM project_types
UNION ALL
SELECT 'Project Technologies:' as table_name, COUNT(*) as count FROM project_technologies
UNION ALL
SELECT 'Section Highlights:' as table_name, COUNT(*) as count FROM section_highlights
UNION ALL
SELECT 'Content Section Tags:' as table_name, COUNT(*) as count FROM content_section_tags
UNION ALL
SELECT 'Photo Albums:' as table_name, COUNT(*) as count FROM photo_albums;


-- ============================================
-- SUCCESS MESSAGE
-- ============================================
SELECT '✅ Cleanup Complete!' as message;
SELECT '✅ You should have 4 unique projects and 4 unique experience sections' as message;
