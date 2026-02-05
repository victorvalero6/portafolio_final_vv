-- ============================================
-- SEED DATA FOR VV PORTFOLIO
-- ============================================
-- Run this in your Supabase SQL Editor
-- ============================================

-- ============================================
-- 1. PROJECTS
-- ============================================

-- First, ensure we have a project type
INSERT INTO project_types (name, slug) 
VALUES ('Web Application', 'web-app')
ON CONFLICT (slug) DO NOTHING;

-- Get the project_type_id
DO $$ 
DECLARE 
  web_app_type_id bigint;
BEGIN
  SELECT id INTO web_app_type_id FROM project_types WHERE slug = 'web-app';

  -- Insert Projects
  INSERT INTO projects (
    code, 
    slug, 
    title, 
    summary, 
    description,
    featured_image_url, 
    featured_image_alt,
    project_type_id,
    status,
    external_url,
    sort_order,
    is_featured
  ) VALUES 
  (
    'PRJ-001',
    'caritas-donation-app',
    'Cáritas Donation Swift App',
    'A modern iOS solution built with Swift to optimize donation flows, bazar coordination, and impact tracking through maps, dashboards, and intelligent tools.',
    'A comprehensive iOS application developed for Cáritas de Monterrey to streamline donation management, coordinate bazaar operations, and track social impact through interactive maps and data dashboards.',
    '/projects/caritas-mockup.jpg',
    'Caritas app preview',
    web_app_type_id,
    'active',
    'https://github.com/victorvalero6/Caritas-de-Monterrey.git',
    1,
    true
  ),
  (
    'PRJ-002',
    'whirlpool-fullstack',
    'Whirlpool Web Platform',
    'Full-stack web application built with React for both frontend and backend, developed for Whirlpool. Features user authentication, dedicated user and admin pages, database integration, and an interactive Unity-based game.',
    'Enterprise-level web platform for Whirlpool featuring complete user management, administrative dashboards, and seamless Unity game integration. Built with React and modern web technologies.',
    '/projects/whirlpool.jpg',
    'Whirlpool project preview',
    web_app_type_id,
    'active',
    'https://github.com/victorvalero6/Whirlpool-React-Web.git',
    2,
    true
  ),
  (
    'PRJ-003',
    'mobile-banking-app',
    'Mobile Banking App',
    'Cross-platform mobile application for digital banking with React Native, Firebase integration, and Plaid API for secure financial transactions.',
    'Modern mobile banking solution featuring real-time account management, transaction history, and secure payment processing with industry-standard security protocols.',
    '/projects/mobile-app.jpg',
    'Mobile app preview',
    web_app_type_id,
    'active',
    '#',
    3,
    false
  ),
  (
    'PRJ-004',
    'space-survival-game',
    'Survival Space Game',
    'Fast-paced arcade space shooter built with vanilla JavaScript and HTML5 Canvas. Pilot your ship through an endless battlefield, destroy incoming enemies, collect power-ups, unleash screen-clearing black holes, and face a final boss.',
    'Retro-style arcade game featuring dynamic enemy spawning, progressive difficulty, power-up systems, and epic boss battles. Built entirely with vanilla JavaScript for optimal performance.',
    '/projects/space-game.jpg',
    'Space game preview',
    web_app_type_id,
    'active',
    'https://github.com/victorvalero6/Space-Game-.git',
    4,
    false
  )
  ON CONFLICT (code) DO UPDATE SET
    title = EXCLUDED.title,
    summary = EXCLUDED.summary,
    description = EXCLUDED.description,
    external_url = EXCLUDED.external_url;

END $$;


-- ============================================
-- 2. TECHNOLOGIES
-- ============================================

INSERT INTO technologies (name, slug) VALUES
  ('Swift', 'swift'),
  ('iOS', 'ios'),
  ('Maps', 'maps'),
  ('Dashboards', 'dashboards'),
  ('React', 'react'),
  ('Unity', 'unity'),
  ('Full Stack', 'full-stack'),
  ('Database', 'database'),
  ('React Native', 'react-native'),
  ('Firebase', 'firebase'),
  ('Plaid', 'plaid'),
  ('JavaScript', 'javascript'),
  ('HTML5 Canvas', 'html5-canvas'),
  ('Game Dev', 'game-dev')
ON CONFLICT (slug) DO NOTHING;


-- ============================================
-- 3. PROJECT-TECHNOLOGY RELATIONSHIPS
-- ============================================

DO $$
DECLARE
  caritas_id bigint;
  whirlpool_id bigint;
  mobile_id bigint;
  space_id bigint;
BEGIN
  -- Get project IDs
  SELECT id INTO caritas_id FROM projects WHERE code = 'PRJ-001';
  SELECT id INTO whirlpool_id FROM projects WHERE code = 'PRJ-002';
  SELECT id INTO mobile_id FROM projects WHERE code = 'PRJ-003';
  SELECT id INTO space_id FROM projects WHERE code = 'PRJ-004';

  -- Caritas technologies
  INSERT INTO project_technologies (project_id, technology_id)
  SELECT caritas_id, id FROM technologies WHERE slug IN ('swift', 'ios', 'maps', 'dashboards')
  ON CONFLICT DO NOTHING;

  -- Whirlpool technologies
  INSERT INTO project_technologies (project_id, technology_id)
  SELECT whirlpool_id, id FROM technologies WHERE slug IN ('react', 'unity', 'full-stack', 'database')
  ON CONFLICT DO NOTHING;

  -- Mobile Banking technologies
  INSERT INTO project_technologies (project_id, technology_id)
  SELECT mobile_id, id FROM technologies WHERE slug IN ('react-native', 'firebase', 'plaid')
  ON CONFLICT DO NOTHING;

  -- Space Game technologies
  INSERT INTO project_technologies (project_id, technology_id)
  SELECT space_id, id FROM technologies WHERE slug IN ('javascript', 'html5-canvas', 'game-dev')
  ON CONFLICT DO NOTHING;
END $$;


-- ============================================
-- 4. EXPERIENCE / ABOUT ME CONTENT
-- ============================================

-- Insert Experience Sections
INSERT INTO content_sections (
  key,
  title,
  subtitle,
  time_range,
  body,
  status,
  sort_order,
  show_in_nav
) VALUES
(
  'experience_01',
  'Creative Technologist',
  'Design & Engineering Focus',
  '2026 — Present',
  'Currently focused on crafting visually striking, vintage-inspired, and unconventional digital designs. I explore the intersection of aesthetics and systems, building experiences that combine front-end, back-end, databases, and APIs with a strong artistic identity. My work is driven by creativity, experimentation, and a clear goal of joining the Apple Developer Academy.',
  'active',
  1,
  false
),
(
  'experience_02',
  'Full-Stack & Applied Computing Projects',
  NULL,
  '2025',
  'Designed and developed a complete web platform from scratch — frontend, backend, databases, APIs — and deployed it publicly. Worked with Unity on an industrial project for Whirlpool, integrating interactive systems and applied computing concepts. As a second major project, I developed a Swift application for Cáritas de Monterrey, combining technology, social impact, and user-centered design. Explored advanced computational methods, functional programming with Racket and Clojure, and complex problem solving.',
  'active',
  2,
  false
),
(
  'experience_03',
  'Systems, Architecture & Low-Level Computing',
  NULL,
  '2024',
  'Deepened my understanding of Object-Oriented Programming in C++, software architecture, and web systems design. Worked with GitHub, explored assembly language, and applied computing concepts to computational biology. Studied software requirements, web architecture, and software architecture, strengthening my systems-thinking approach.',
  'active',
  3,
  false
),
(
  'experience_04',
  'Foundations of Computer Science',
  NULL,
  '2023',
  'Built a solid base in HTML, CSS, C++, and Python, focusing on language fundamentals, data structures, and practice-driven projects. Developed computational thinking, object-oriented reasoning, and problem-solving skills through hands-on experimentation.',
  'active',
  4,
  false
)
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  subtitle = EXCLUDED.subtitle,
  time_range = EXCLUDED.time_range,
  body = EXCLUDED.body,
  sort_order = EXCLUDED.sort_order;


-- ============================================
-- 5. SECTION HIGHLIGHTS (Skills for each experience)
-- ============================================

DO $$
DECLARE
  exp1_id bigint;
  exp2_id bigint;
  exp3_id bigint;
  exp4_id bigint;
BEGIN
  -- Get experience IDs
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
    (exp1_id, 'Mobile', 6)
  ON CONFLICT DO NOTHING;

  -- Experience 2 skills
  INSERT INTO section_highlights (content_section_id, text, sort_order) VALUES
    (exp2_id, 'Full-Stack Development', 1),
    (exp2_id, 'Swift', 2),
    (exp2_id, 'Unity', 3),
    (exp2_id, 'Databases', 4),
    (exp2_id, 'APIs', 5),
    (exp2_id, 'Functional Programming', 6)
  ON CONFLICT DO NOTHING;

  -- Experience 3 skills
  INSERT INTO section_highlights (content_section_id, text, sort_order) VALUES
    (exp3_id, 'OOP', 1),
    (exp3_id, 'Software Architecture', 2),
    (exp3_id, 'Assembly', 3),
    (exp3_id, 'Computational Biology', 4),
    (exp3_id, 'Git', 5)
  ON CONFLICT DO NOTHING;

  -- Experience 4 skills
  INSERT INTO section_highlights (content_section_id, text, sort_order) VALUES
    (exp4_id, 'Programming Fundamentals', 1),
    (exp4_id, 'Data Structures', 2),
    (exp4_id, 'OOP Thinking', 3)
  ON CONFLICT DO NOTHING;
END $$;


-- ============================================
-- 6. PHOTO ALBUM (Optional - for About section)
-- ============================================

INSERT INTO photo_albums (key, title, description, is_active, sort_order)
VALUES (
  'about-widget',
  'Personal Photos',
  'Photo collection for the about section',
  true,
  1
)
ON CONFLICT (key) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- Note: You'll need to add actual photos to the photos table
-- Example:
-- INSERT INTO photos (album_id, image_url, alt_text, sort_order)
-- SELECT id, '/photos/photo1.png', 'Memory 01', 1
-- FROM photo_albums WHERE key = 'about-widget';


-- ============================================
-- VERIFICATION QUERIES
-- ============================================
-- Run these to verify the data was inserted correctly:

-- SELECT * FROM projects ORDER BY sort_order;
-- SELECT * FROM content_sections WHERE key LIKE 'experience_%' ORDER BY sort_order;
-- SELECT cs.title, sh.text FROM content_sections cs 
-- JOIN section_highlights sh ON cs.id = sh.content_section_id 
-- WHERE cs.key LIKE 'experience_%' ORDER BY cs.sort_order, sh.sort_order;
