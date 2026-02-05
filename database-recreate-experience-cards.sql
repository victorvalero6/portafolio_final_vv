-- ============================================
-- RECREATE EXPERIENCE CARDS FROM SCRATCH
-- ============================================
-- This script will:
-- 1. Delete existing experience cards and their relationships
-- 2. Insert fresh experience cards with all translations
-- ============================================

-- ============================================
-- STEP 1: DELETE EXISTING EXPERIENCE CARDS
-- ============================================

-- Delete section_highlights for experience cards
DELETE FROM section_highlights
WHERE content_section_id IN (
  SELECT id FROM content_sections WHERE key LIKE 'experience_%'
);

-- Delete content_section_tags for experience cards
DELETE FROM content_section_tags
WHERE content_section_id IN (
  SELECT id FROM content_sections WHERE key LIKE 'experience_%'
);

-- Delete the experience cards themselves
DELETE FROM content_sections
WHERE key LIKE 'experience_%';

SELECT '✅ Old experience cards deleted' as status;


-- ============================================
-- STEP 2: INSERT NEW EXPERIENCE CARDS
-- ============================================

-- Experience 01: 2026 — Present
INSERT INTO content_sections (
  key,
  title,
  subtitle,
  time_range,
  body,
  title_en,
  title_es,
  title_fr,
  title_de,
  subtitle_en,
  subtitle_es,
  subtitle_fr,
  subtitle_de,
  body_en,
  body_es,
  body_fr,
  body_de,
  status,
  sort_order,
  show_in_nav
) VALUES (
  'experience_01',
  'Creative Technologist',
  'Design & Engineering Focus',
  '2026 — Present',
  'Currently focused on crafting visually striking, vintage-inspired, and unconventional digital designs. I explore the intersection of aesthetics and systems, building experiences that combine front-end, back-end, databases, and APIs with a strong artistic identity. My work is driven by creativity, experimentation, and a clear goal of joining the Apple Developer Academy.',
  'Creative Technologist',
  'Tecnólogo Creativo',
  'Technologue Créatif',
  'Kreativer Technologe',
  'Design & Engineering Focus',
  'Enfoque en Diseño e Ingeniería',
  'Focus Design & Ingénierie',
  'Fokus auf Design & Technik',
  'Currently focused on crafting visually striking, vintage-inspired, and unconventional digital designs. I explore the intersection of aesthetics and systems, building experiences that combine front-end, back-end, databases, and APIs with a strong artistic identity. My work is driven by creativity, experimentation, and a clear goal of joining the Apple Developer Academy.',
  'Actualmente enfocado en crear diseños digitales visualmente impactantes, de inspiración vintage y poco convencionales. Exploro la intersección entre estética y sistemas, construyendo experiencias que combinan front-end, back-end, bases de datos y APIs con una fuerte identidad artística. Mi trabajo está impulsado por la creatividad, la experimentación y el objetivo claro de unirme a la Apple Developer Academy.',
  'Actuellement concentré sur la création de designs numériques visuellement frappants, d''inspiration vintage et non conventionnels. J''explore l''intersection de l''esthétique et des systèmes, en construisant des expériences qui combinent front-end, back-end, bases de données et APIs avec une forte identité artistique. Mon travail est motivé par la créativité, l''expérimentation et l''objectif clair de rejoindre l''Apple Developer Academy.',
  'Derzeit konzentriert auf die Gestaltung visuell beeindruckender, vintage-inspirierter und unkonventioneller digitaler Designs. Ich erforsche die Schnittstelle von Ästhetik und Systemen und baue Erlebnisse, die Frontend, Backend, Datenbanken und APIs mit einer starken künstlerischen Identität verbinden. Meine Arbeit wird von Kreativität, Experimenten und dem klaren Ziel angetrieben, der Apple Developer Academy beizutreten.',
  'active',
  1,
  false
);

-- Experience 02: 2025
INSERT INTO content_sections (
  key,
  title,
  subtitle,
  time_range,
  body,
  title_en,
  title_es,
  title_fr,
  title_de,
  subtitle_en,
  subtitle_es,
  subtitle_fr,
  subtitle_de,
  body_en,
  body_es,
  body_fr,
  body_de,
  status,
  sort_order,
  show_in_nav
) VALUES (
  'experience_02',
  'Full-Stack & Applied Computing Projects',
  'Full-Stack Development',
  '2025',
  'Designed and developed a complete web platform from scratch — frontend, backend, databases, APIs — and deployed it publicly. Worked with Unity on an industrial project for Whirlpool, integrating interactive systems and applied computing concepts. As a second major project, I developed a Swift application for Cáritas de Monterrey, combining technology, social impact, and user-centered design. Explored advanced computational methods, functional programming with Racket and Clojure, and complex problem solving.',
  'Full-Stack & Applied Computing Projects',
  'Proyectos Full-Stack y Computación Aplicada',
  'Projets Full-Stack et Informatique Appliquée',
  'Full-Stack & Angewandte Informatik Projekte',
  'Full-Stack Development',
  'Desarrollo Full-Stack',
  'Développement Full-Stack',
  'Full-Stack-Entwicklung',
  'Designed and developed a complete web platform from scratch — frontend, backend, databases, APIs — and deployed it publicly. Worked with Unity on an industrial project for Whirlpool, integrating interactive systems and applied computing concepts. As a second major project, I developed a Swift application for Cáritas de Monterrey, combining technology, social impact, and user-centered design. Explored advanced computational methods, functional programming with Racket and Clojure, and complex problem solving.',
  'Diseñé y desarrollé una plataforma web completa desde cero — frontend, backend, bases de datos, APIs — y la desplegué públicamente. Trabajé con Unity en un proyecto industrial para Whirlpool, integrando sistemas interactivos y conceptos de computación aplicada. Como segundo proyecto importante, desarrollé una aplicación Swift para Cáritas de Monterrey, combinando tecnología, impacto social y diseño centrado en el usuario. Exploré métodos computacionales avanzados, programación funcional con Racket y Clojure, y resolución de problemas complejos.',
  'Conçu et développé une plateforme web complète de zéro — frontend, backend, bases de données, APIs — et l''ai déployée publiquement. Travaillé avec Unity sur un projet industriel pour Whirlpool, intégrant des systèmes interactifs et des concepts d''informatique appliquée. Comme deuxième projet majeur, j''ai développé une application Swift pour Cáritas de Monterrey, combinant technologie, impact social et design centré sur l''utilisateur. Exploré des méthodes computationnelles avancées, programmation fonctionnelle avec Racket et Clojure, et résolution de problèmes complexes.',
  'Entwurf und Entwicklung einer kompletten Webplattform von Grund auf — Frontend, Backend, Datenbanken, APIs — und öffentlich bereitgestellt. Arbeit mit Unity an einem Industrieprojekt für Whirlpool, Integration interaktiver Systeme und angewandter Informatikkonzepte. Als zweites Hauptprojekt entwickelte ich eine Swift-Anwendung für Cáritas de Monterrey, die Technologie, soziale Auswirkungen und benutzerzentriertes Design verbindet. Erforschung fortgeschrittener Rechenmethoden, funktionale Programmierung mit Racket und Clojure und komplexe Problemlösung.',
  'active',
  2,
  false
);

-- Experience 03: 2024
INSERT INTO content_sections (
  key,
  title,
  subtitle,
  time_range,
  body,
  title_en,
  title_es,
  title_fr,
  title_de,
  subtitle_en,
  subtitle_es,
  subtitle_fr,
  subtitle_de,
  body_en,
  body_es,
  body_fr,
  body_de,
  status,
  sort_order,
  show_in_nav
) VALUES (
  'experience_03',
  'Systems, Architecture & Low-Level Computing',
  'Systems & Architecture',
  '2024',
  'Deepened my understanding of Object-Oriented Programming in C++, software architecture, and web systems design. Worked with GitHub, explored assembly language, and applied computing concepts to computational biology. Studied software requirements, web architecture, and software architecture, strengthening my systems-thinking approach.',
  'Systems, Architecture & Low-Level Computing',
  'Sistemas, Arquitectura y Computación de Bajo Nivel',
  'Systèmes, Architecture et Informatique Bas Niveau',
  'Systeme, Architektur & Low-Level-Computing',
  'Systems & Architecture',
  'Sistemas y Arquitectura',
  'Systèmes et Architecture',
  'Systeme & Architektur',
  'Deepened my understanding of Object-Oriented Programming in C++, software architecture, and web systems design. Worked with GitHub, explored assembly language, and applied computing concepts to computational biology. Studied software requirements, web architecture, and software architecture, strengthening my systems-thinking approach.',
  'Profundicé mi comprensión de Programación Orientada a Objetos en C++, arquitectura de software y diseño de sistemas web. Trabajé con GitHub, exploré lenguaje ensamblador y apliqué conceptos de computación a biología computacional. Estudié requisitos de software, arquitectura web y arquitectura de software, fortaleciendo mi enfoque de pensamiento sistémico.',
  'Approfondi ma compréhension de la Programmation Orientée Objet en C++, de l''architecture logicielle et de la conception de systèmes web. Travaillé avec GitHub, exploré le langage assembleur et appliqué des concepts informatiques à la biologie computationnelle. Étudié les exigences logicielles, l''architecture web et l''architecture logicielle, renforçant mon approche de pensée systémique.',
  'Vertiefung meines Verständnisses von Objektorientierter Programmierung in C++, Softwarearchitektur und Web-Systemdesign. Arbeit mit GitHub, Erforschung von Assemblersprache und Anwendung von Informatikkonzepten auf Computerbiologie. Studium von Softwareanforderungen, Webarchitektur und Softwarearchitektur, Stärkung meines systemischen Denkansatzes.',
  'active',
  3,
  false
);

-- Experience 04: 2023
INSERT INTO content_sections (
  key,
  title,
  subtitle,
  time_range,
  body,
  title_en,
  title_es,
  title_fr,
  title_de,
  subtitle_en,
  subtitle_es,
  subtitle_fr,
  subtitle_de,
  body_en,
  body_es,
  body_fr,
  body_de,
  status,
  sort_order,
  show_in_nav
) VALUES (
  'experience_04',
  'Foundations of Computer Science',
  'Core Programming',
  '2023',
  'Built a solid base in HTML, CSS, C++, and Python, focusing on language fundamentals, data structures, and practice-driven projects. Developed computational thinking, object-oriented reasoning, and problem-solving skills through hands-on experimentation.',
  'Foundations of Computer Science',
  'Fundamentos de Ciencias de la Computación',
  'Fondamentaux de l''Informatique',
  'Grundlagen der Informatik',
  'Core Programming',
  'Programación Base',
  'Programmation de Base',
  'Kern-Programmierung',
  'Built a solid base in HTML, CSS, C++, and Python, focusing on language fundamentals, data structures, and practice-driven projects. Developed computational thinking, object-oriented reasoning, and problem-solving skills through hands-on experimentation.',
  'Construí una base sólida en HTML, CSS, C++ y Python, enfocándome en fundamentos del lenguaje, estructuras de datos y proyectos prácticos. Desarrollé pensamiento computacional, razonamiento orientado a objetos y habilidades de resolución de problemas a través de experimentación práctica.',
  'Construit une base solide en HTML, CSS, C++ et Python, en me concentrant sur les fondamentaux du langage, les structures de données et les projets pratiques. Développé la pensée computationnelle, le raisonnement orienté objet et les compétences de résolution de problèmes à travers l''expérimentation pratique.',
  'Aufbau einer soliden Basis in HTML, CSS, C++ und Python, mit Fokus auf Sprachgrundlagen, Datenstrukturen und praxisorientierte Projekte. Entwicklung von rechnerischem Denken, objektorientiertem Denken und Problemlösungsfähigkeiten durch praktische Experimente.',
  'active',
  4,
  false
);

SELECT '✅ New experience cards inserted' as status;


-- ============================================
-- STEP 3: INSERT SECTION HIGHLIGHTS (SKILLS)
-- ============================================

DO $$
DECLARE
  exp1_id bigint;
  exp2_id bigint;
  exp3_id bigint;
  exp4_id bigint;
BEGIN
  -- Get the IDs of the newly created experience cards
  SELECT id INTO exp1_id FROM content_sections WHERE key = 'experience_01';
  SELECT id INTO exp2_id FROM content_sections WHERE key = 'experience_02';
  SELECT id INTO exp3_id FROM content_sections WHERE key = 'experience_03';
  SELECT id INTO exp4_id FROM content_sections WHERE key = 'experience_04';

  -- Experience 1 skills
  INSERT INTO section_highlights (content_section_id, text, sort_order) VALUES
    (exp1_id, 'Creative Direction', 1),
    (exp1_id, 'Frontend', 2),
    (exp1_id, 'Backend', 3),
    (exp1_id, 'APIs', 4),
    (exp1_id, 'Visual Systems', 5),
    (exp1_id, 'Mobile', 6);

  -- Experience 2 skills
  INSERT INTO section_highlights (content_section_id, text, sort_order) VALUES
    (exp2_id, 'Full-Stack Development', 1),
    (exp2_id, 'Swift', 2),
    (exp2_id, 'Unity', 3),
    (exp2_id, 'Databases', 4),
    (exp2_id, 'APIs', 5),
    (exp2_id, 'Functional Programming', 6);

  -- Experience 3 skills
  INSERT INTO section_highlights (content_section_id, text, sort_order) VALUES
    (exp3_id, 'OOP', 1),
    (exp3_id, 'Software Architecture', 2),
    (exp3_id, 'Assembly', 3),
    (exp3_id, 'Computational Biology', 4),
    (exp3_id, 'Git', 5);

  -- Experience 4 skills
  INSERT INTO section_highlights (content_section_id, text, sort_order) VALUES
    (exp4_id, 'Programming Fundamentals', 1),
    (exp4_id, 'Data Structures', 2),
    (exp4_id, 'OOP Thinking', 3);
END $$;

SELECT '✅ Skills/highlights inserted' as status;


-- ============================================
-- STEP 4: VERIFICATION
-- ============================================

SELECT '=== VERIFICATION REPORT ===' as report;

-- Show all experience cards
SELECT 
  id,
  key,
  title_en,
  subtitle_en,
  time_range,
  sort_order
FROM content_sections
WHERE key LIKE 'experience_%'
ORDER BY sort_order;

-- Count highlights per experience
SELECT 
  cs.key,
  cs.title_en,
  cs.sort_order,
  COUNT(sh.id) as highlight_count
FROM content_sections cs
LEFT JOIN section_highlights sh ON cs.id = sh.content_section_id
WHERE cs.key LIKE 'experience_%'
GROUP BY cs.key, cs.title_en, cs.sort_order
ORDER BY cs.sort_order;

-- Summary
SELECT 
  'Total Experience Cards' as metric,
  COUNT(*) as count
FROM content_sections
WHERE key LIKE 'experience_%'
UNION ALL
SELECT 
  'Total Highlights/Skills' as metric,
  COUNT(*) as count
FROM section_highlights sh
JOIN content_sections cs ON sh.content_section_id = cs.id
WHERE cs.key LIKE 'experience_%';


-- ============================================
-- SUCCESS MESSAGE
-- ============================================
SELECT '🎉 Experience cards recreated successfully!' as message;
SELECT '✅ 4 experience cards with all translations (EN, ES, FR, DE)' as status
UNION ALL
SELECT '✅ All skills/highlights added' as status
UNION ALL
SELECT '✅ Cards ready to display in the app' as status;
