-- ============================================
-- CUSTOM SUBTITLE OPTIONS
-- ============================================
-- Choose which version you prefer and run only that section
-- ============================================


-- ============================================
-- OPTION 1: Technical Focus (Recommended)
-- ============================================

-- experience_02 (2025)
UPDATE content_sections
SET
  subtitle_en = 'Full-Stack Development',
  subtitle_es = 'Desarrollo Full-Stack',
  subtitle_fr = 'Développement Full-Stack',
  subtitle_de = 'Full-Stack-Entwicklung'
WHERE key = 'experience_02';

-- experience_03 (2024)
UPDATE content_sections
SET
  subtitle_en = 'Systems & Architecture',
  subtitle_es = 'Sistemas y Arquitectura',
  subtitle_fr = 'Systèmes et Architecture',
  subtitle_de = 'Systeme & Architektur'
WHERE key = 'experience_03';

-- experience_04 (2023)
UPDATE content_sections
SET
  subtitle_en = 'Core Programming',
  subtitle_es = 'Programación Base',
  subtitle_fr = 'Programmation de Base',
  subtitle_de = 'Kern-Programmierung'
WHERE key = 'experience_04';


-- ============================================
-- OPTION 2: Role-Based
-- ============================================

-- experience_02 (2025)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Software Engineer',
--   subtitle_es = 'Ingeniero de Software',
--   subtitle_fr = 'Ingénieur Logiciel',
--   subtitle_de = 'Software-Ingenieur'
-- WHERE key = 'experience_02';

-- experience_03 (2024)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Systems Developer',
--   subtitle_es = 'Desarrollador de Sistemas',
--   subtitle_fr = 'Développeur de Systèmes',
--   subtitle_de = 'Systementwickler'
-- WHERE key = 'experience_03';

-- experience_04 (2023)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Computer Science Student',
--   subtitle_es = 'Estudiante de Ciencias de la Computación',
--   subtitle_fr = 'Étudiant en Informatique',
--   subtitle_de = 'Informatikstudent'
-- WHERE key = 'experience_04';


-- ============================================
-- OPTION 3: Short & Simple
-- ============================================

-- experience_02 (2025)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Building & Deploying',
--   subtitle_es = 'Construcción y Despliegue',
--   subtitle_fr = 'Construction et Déploiement',
--   subtitle_de = 'Aufbau & Bereitstellung'
-- WHERE key = 'experience_02';

-- experience_03 (2024)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Low-Level Computing',
--   subtitle_es = 'Computación de Bajo Nivel',
--   subtitle_fr = 'Informatique Bas Niveau',
--   subtitle_de = 'Low-Level-Computing'
-- WHERE key = 'experience_03';

-- experience_04 (2023)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'First Steps in Code',
--   subtitle_es = 'Primeros Pasos en Código',
--   subtitle_fr = 'Premiers Pas dans le Code',
--   subtitle_de = 'Erste Schritte im Code'
-- WHERE key = 'experience_04';


-- ============================================
-- OPTION 4: Action-Oriented
-- ============================================

-- experience_02 (2025)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Shipping Production Code',
--   subtitle_es = 'Código en Producción',
--   subtitle_fr = 'Code en Production',
--   subtitle_de = 'Produktionscode'
-- WHERE key = 'experience_02';

-- experience_03 (2024)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Exploring System Design',
--   subtitle_es = 'Explorando Diseño de Sistemas',
--   subtitle_fr = 'Explorer la Conception de Systèmes',
--   subtitle_de = 'Systemdesign Erkunden'
-- WHERE key = 'experience_03';

-- experience_04 (2023)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Learning Fundamentals',
--   subtitle_es = 'Aprendiendo Fundamentos',
--   subtitle_fr = 'Apprendre les Fondamentaux',
--   subtitle_de = 'Grundlagen Lernen'
-- WHERE key = 'experience_04';


-- ============================================
-- CUSTOM: Write Your Own
-- ============================================

-- Replace 'Your Custom Subtitle' with your preferred text

-- experience_02 (2025)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Your Custom Subtitle EN',
--   subtitle_es = 'Tu Subtítulo Personalizado ES',
--   subtitle_fr = 'Votre Sous-titre Personnalisé FR',
--   subtitle_de = 'Ihr Benutzerdefinierter Untertitel DE'
-- WHERE key = 'experience_02';

-- experience_03 (2024)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Your Custom Subtitle EN',
--   subtitle_es = 'Tu Subtítulo Personalizado ES',
--   subtitle_fr = 'Votre Sous-titre Personnalisé FR',
--   subtitle_de = 'Ihr Benutzerdefinierter Untertitel DE'
-- WHERE key = 'experience_03';

-- experience_04 (2023)
-- UPDATE content_sections
-- SET
--   subtitle_en = 'Your Custom Subtitle EN',
--   subtitle_es = 'Tu Subtítulo Personalizado ES',
--   subtitle_fr = 'Votre Sous-titre Personnalisé FR',
--   subtitle_de = 'Ihr Benutzerdefinierter Untertitel DE'
-- WHERE key = 'experience_04';


-- ============================================
-- VERIFICATION
-- ============================================

SELECT 
  key,
  time_range,
  title_en,
  subtitle_en,
  subtitle_es
FROM content_sections
WHERE key LIKE 'experience_%'
ORDER BY sort_order;
