-- ============================================
-- REMOVE DUPLICATES FROM DATABASE
-- ============================================
-- Run this script to clean up duplicate entries
-- ============================================

-- ============================================
-- 1. REMOVE DUPLICATE PROJECTS
-- ============================================

-- Keep only the first occurrence of each project (by code)
DELETE FROM projects
WHERE id NOT IN (
  SELECT MIN(id)
  FROM projects
  GROUP BY code
);

-- Verify projects (should show 4 unique projects)
-- SELECT code, title, COUNT(*) FROM projects GROUP BY code, title;


-- ============================================
-- 2. REMOVE DUPLICATE CONTENT SECTIONS
-- ============================================

-- Keep only the first occurrence of each content section (by key)
DELETE FROM content_sections
WHERE id NOT IN (
  SELECT MIN(id)
  FROM content_sections
  GROUP BY key
);

-- Verify content sections (should show 4 unique sections)
-- SELECT key, title, COUNT(*) FROM content_sections GROUP BY key, title;


-- ============================================
-- 3. REMOVE DUPLICATE SECTION HIGHLIGHTS
-- ============================================

-- Remove duplicate highlights (same content_section_id and text)
DELETE FROM section_highlights
WHERE id NOT IN (
  SELECT MIN(id)
  FROM section_highlights
  GROUP BY content_section_id, text
);

-- Verify section highlights
-- SELECT content_section_id, text, COUNT(*) FROM section_highlights GROUP BY content_section_id, text;


-- ============================================
-- 4. REMOVE DUPLICATE PROJECT TECHNOLOGIES
-- ============================================

-- Remove duplicate project-technology relationships
DELETE FROM project_technologies
WHERE ctid NOT IN (
  SELECT MIN(ctid)
  FROM project_technologies
  GROUP BY project_id, technology_id
);

-- Verify project_technologies
-- SELECT project_id, technology_id, COUNT(*) FROM project_technologies GROUP BY project_id, technology_id;


-- ============================================
-- 5. REMOVE DUPLICATE TECHNOLOGIES
-- ============================================

-- Keep only the first occurrence of each technology (by slug)
DELETE FROM technologies
WHERE id NOT IN (
  SELECT MIN(id)
  FROM technologies
  GROUP BY slug
);

-- Verify technologies
-- SELECT slug, name, COUNT(*) FROM technologies GROUP BY slug, name;


-- ============================================
-- 6. REMOVE DUPLICATE SECTION TAGS
-- ============================================

-- Keep only the first occurrence of each section tag (by slug)
DELETE FROM section_tags
WHERE id NOT IN (
  SELECT MIN(id)
  FROM section_tags
  GROUP BY slug
);

-- Verify section_tags
-- SELECT slug, name, COUNT(*) FROM section_tags GROUP BY slug, name;


-- ============================================
-- 7. REMOVE DUPLICATE CONTENT SECTION TAGS
-- ============================================

-- Remove duplicate content_section_tags relationships
DELETE FROM content_section_tags
WHERE ctid NOT IN (
  SELECT MIN(ctid)
  FROM content_section_tags
  GROUP BY content_section_id, section_tag_id
);

-- Verify content_section_tags
-- SELECT content_section_id, section_tag_id, COUNT(*) FROM content_section_tags GROUP BY content_section_id, section_tag_id;


-- ============================================
-- 8. REMOVE DUPLICATE PROJECT TYPES
-- ============================================

-- Keep only the first occurrence of each project type (by slug)
DELETE FROM project_types
WHERE id NOT IN (
  SELECT MIN(id)
  FROM project_types
  GROUP BY slug
);

-- Verify project_types
-- SELECT slug, name, COUNT(*) FROM project_types GROUP BY slug, name;


-- ============================================
-- 9. REMOVE DUPLICATE PHOTO ALBUMS
-- ============================================

-- Keep only the first occurrence of each photo album (by key)
DELETE FROM photo_albums
WHERE id NOT IN (
  SELECT MIN(id)
  FROM photo_albums
  GROUP BY key
);

-- Verify photo_albums
-- SELECT key, title, COUNT(*) FROM photo_albums GROUP BY key, title;


-- ============================================
-- VERIFICATION QUERIES
-- ============================================
-- Run these to verify cleanup was successful:

-- Check projects count (should be 4)
SELECT 'Projects Count' as table_name, COUNT(*) as count FROM projects;

-- Check content_sections count (should be 4)
SELECT 'Content Sections Count' as table_name, COUNT(*) as count FROM content_sections;

-- Check section_highlights count
SELECT 'Section Highlights Count' as table_name, COUNT(*) as count FROM section_highlights;

-- Check technologies count
SELECT 'Technologies Count' as table_name, COUNT(*) as count FROM technologies;

-- Check project_technologies relationships
SELECT 'Project Technologies Count' as table_name, COUNT(*) as count FROM project_technologies;

-- List all projects
SELECT code, title_en, title_es FROM projects ORDER BY sort_order;

-- List all experiences
SELECT key, title_en, title_es FROM content_sections WHERE key LIKE 'experience_%' ORDER BY sort_order;

-- ============================================
-- SUCCESS MESSAGE
-- ============================================
SELECT '✅ Duplicates removed successfully!' as message;
