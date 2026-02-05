-- ============================================
-- ADD SUBTITLES TO EXPERIENCE CARDS
-- ============================================
-- This adds subtitles to experience_02, experience_03, and experience_04
-- (experience_01 already has a subtitle)
-- ============================================

-- ============================================
-- UPDATE EXPERIENCE_02 (2025)
-- ============================================

UPDATE content_sections
SET
  subtitle = 'Full-Stack Development',
  subtitle_en = 'Full-Stack Development',
  subtitle_es = 'Desarrollo Full-Stack',
  subtitle_fr = 'Développement Full-Stack',
  subtitle_de = 'Full-Stack-Entwicklung'
WHERE key = 'experience_02';


-- ============================================
-- UPDATE EXPERIENCE_03 (2024)
-- ============================================

UPDATE content_sections
SET
  subtitle = 'Systems & Architecture',
  subtitle_en = 'Systems & Architecture',
  subtitle_es = 'Sistemas y Arquitectura',
  subtitle_fr = 'Systèmes et Architecture',
  subtitle_de = 'Systeme & Architektur'
WHERE key = 'experience_03';


-- ============================================
-- UPDATE EXPERIENCE_04 (2023)
-- ============================================

UPDATE content_sections
SET
  subtitle = 'Core Programming',
  subtitle_en = 'Core Programming',
  subtitle_es = 'Programación Base',
  subtitle_fr = 'Programmation de Base',
  subtitle_de = 'Kern-Programmierung'
WHERE key = 'experience_04';


-- ============================================
-- VERIFICATION
-- ============================================

-- Check all subtitles
SELECT 
  key,
  time_range,
  title_en,
  subtitle_en,
  subtitle_es,
  subtitle_fr,
  subtitle_de
FROM content_sections
WHERE key LIKE 'experience_%'
ORDER BY sort_order;


-- ============================================
-- SUCCESS MESSAGE
-- ============================================
SELECT '✅ Subtitles added successfully!' as message;
SELECT 'experience_01: Has subtitle (already existed)' as status
UNION ALL
SELECT 'experience_02: Subtitle added ✅' as status
UNION ALL
SELECT 'experience_03: Subtitle added ✅' as status
UNION ALL
SELECT 'experience_04: Subtitle added ✅' as status;
