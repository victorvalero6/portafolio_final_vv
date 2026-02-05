-- ============================================
-- MULTI-LANGUAGE SUPPORT FOR DATABASE
-- ============================================
-- This script adds language support to your database
-- so content can be stored in multiple languages
-- ============================================

-- ============================================
-- OPTION 1: Add language columns (Simple approach)
-- ============================================

-- Add language columns to projects table
ALTER TABLE projects 
  ADD COLUMN IF NOT EXISTS title_en TEXT,
  ADD COLUMN IF NOT EXISTS title_es TEXT,
  ADD COLUMN IF NOT EXISTS title_fr TEXT,
  ADD COLUMN IF NOT EXISTS title_de TEXT,
  ADD COLUMN IF NOT EXISTS summary_en TEXT,
  ADD COLUMN IF NOT EXISTS summary_es TEXT,
  ADD COLUMN IF NOT EXISTS summary_fr TEXT,
  ADD COLUMN IF NOT EXISTS summary_de TEXT,
  ADD COLUMN IF NOT EXISTS description_en TEXT,
  ADD COLUMN IF NOT EXISTS description_es TEXT,
  ADD COLUMN IF NOT EXISTS description_fr TEXT,
  ADD COLUMN IF NOT EXISTS description_de TEXT;

-- Copy existing data to English columns
UPDATE projects 
SET 
  title_en = title,
  summary_en = summary,
  description_en = description
WHERE title_en IS NULL;

-- Add language columns to content_sections
ALTER TABLE content_sections
  ADD COLUMN IF NOT EXISTS title_en TEXT,
  ADD COLUMN IF NOT EXISTS title_es TEXT,
  ADD COLUMN IF NOT EXISTS title_fr TEXT,
  ADD COLUMN IF NOT EXISTS title_de TEXT,
  ADD COLUMN IF NOT EXISTS subtitle_en TEXT,
  ADD COLUMN IF NOT EXISTS subtitle_es TEXT,
  ADD COLUMN IF NOT EXISTS subtitle_fr TEXT,
  ADD COLUMN IF NOT EXISTS subtitle_de TEXT,
  ADD COLUMN IF NOT EXISTS body_en TEXT,
  ADD COLUMN IF NOT EXISTS body_es TEXT,
  ADD COLUMN IF NOT EXISTS body_fr TEXT,
  ADD COLUMN IF NOT EXISTS body_de TEXT;

-- Copy existing data to English columns
UPDATE content_sections 
SET 
  title_en = title,
  subtitle_en = subtitle,
  body_en = body
WHERE title_en IS NULL;


-- ============================================
-- SPANISH TRANSLATIONS (ES)
-- ============================================

-- Projects - Spanish
UPDATE projects SET
  title_es = 'App Cáritas Donaciones Swift',
  summary_es = 'Una solución iOS moderna construida con Swift para optimizar flujos de donación, coordinación de bazares y seguimiento de impacto a través de mapas, dashboards y herramientas inteligentes.',
  description_es = 'Una aplicación iOS integral desarrollada para Cáritas de Monterrey para optimizar la gestión de donaciones, coordinar operaciones de bazar y rastrear el impacto social a través de mapas interactivos y dashboards de datos.'
WHERE code = 'PRJ-001';

UPDATE projects SET
  title_es = 'Plataforma Web Whirlpool',
  summary_es = 'Aplicación web full-stack construida con React para frontend y backend, desarrollada para Whirlpool. Incluye autenticación de usuarios, páginas dedicadas para usuarios y administradores, integración de base de datos y un juego interactivo basado en Unity.',
  description_es = 'Plataforma web de nivel empresarial para Whirlpool con gestión completa de usuarios, dashboards administrativos e integración perfecta de juegos Unity. Construido con React y tecnologías web modernas.'
WHERE code = 'PRJ-002';

UPDATE projects SET
  title_es = 'App de Banca Móvil',
  summary_es = 'Aplicación móvil multiplataforma para banca digital con React Native, integración Firebase y API Plaid para transacciones financieras seguras.',
  description_es = 'Solución de banca móvil moderna con gestión de cuentas en tiempo real, historial de transacciones y procesamiento seguro de pagos con protocolos de seguridad estándar de la industria.'
WHERE code = 'PRJ-003';

UPDATE projects SET
  title_es = 'Juego de Supervivencia Espacial',
  summary_es = 'Shooter espacial arcade de ritmo rápido construido con JavaScript vanilla y HTML5 Canvas. Pilota tu nave a través de un campo de batalla interminable, destruye enemigos, recolecta mejoras, desata agujeros negros y enfrenta un jefe final.',
  description_es = 'Juego arcade estilo retro con generación dinámica de enemigos, dificultad progresiva, sistemas de mejoras y épicas batallas contra jefes. Construido completamente con JavaScript vanilla para un rendimiento óptimo.'
WHERE code = 'PRJ-004';


-- Experience Sections - Spanish
UPDATE content_sections SET
  title_es = 'Tecnólogo Creativo',
  subtitle_es = 'Enfoque en Diseño e Ingeniería',
  body_es = 'Actualmente enfocado en crear diseños digitales visualmente impactantes, de inspiración vintage y poco convencionales. Exploro la intersección entre estética y sistemas, construyendo experiencias que combinan front-end, back-end, bases de datos y APIs con una fuerte identidad artística. Mi trabajo está impulsado por la creatividad, la experimentación y el objetivo claro de unirme a la Apple Developer Academy.'
WHERE key = 'experience_01';

UPDATE content_sections SET
  title_es = 'Proyectos Full-Stack y Computación Aplicada',
  body_es = 'Diseñé y desarrollé una plataforma web completa desde cero — frontend, backend, bases de datos, APIs — y la desplegué públicamente. Trabajé con Unity en un proyecto industrial para Whirlpool, integrando sistemas interactivos y conceptos de computación aplicada. Como segundo proyecto importante, desarrollé una aplicación Swift para Cáritas de Monterrey, combinando tecnología, impacto social y diseño centrado en el usuario. Exploré métodos computacionales avanzados, programación funcional con Racket y Clojure, y resolución de problemas complejos.'
WHERE key = 'experience_02';

UPDATE content_sections SET
  title_es = 'Sistemas, Arquitectura y Computación de Bajo Nivel',
  body_es = 'Profundicé mi comprensión de Programación Orientada a Objetos en C++, arquitectura de software y diseño de sistemas web. Trabajé con GitHub, exploré lenguaje ensamblador y apliqué conceptos de computación a biología computacional. Estudié requisitos de software, arquitectura web y arquitectura de software, fortaleciendo mi enfoque de pensamiento sistémico.'
WHERE key = 'experience_03';

UPDATE content_sections SET
  title_es = 'Fundamentos de Ciencias de la Computación',
  body_es = 'Construí una base sólida en HTML, CSS, C++ y Python, enfocándome en fundamentos del lenguaje, estructuras de datos y proyectos prácticos. Desarrollé pensamiento computacional, razonamiento orientado a objetos y habilidades de resolución de problemas a través de experimentación práctica.'
WHERE key = 'experience_04';


-- ============================================
-- FRENCH TRANSLATIONS (FR)
-- ============================================

-- Projects - French
UPDATE projects SET
  title_fr = 'App Cáritas Donation Swift',
  summary_fr = 'Une solution iOS moderne construite avec Swift pour optimiser les flux de dons, la coordination des bazars et le suivi de l''impact via des cartes, tableaux de bord et outils intelligents.',
  description_fr = 'Application iOS complète développée pour Cáritas de Monterrey pour rationaliser la gestion des dons, coordonner les opérations de bazar et suivre l''impact social via des cartes interactives et des tableaux de bord de données.'
WHERE code = 'PRJ-001';

UPDATE projects SET
  title_fr = 'Plateforme Web Whirlpool',
  summary_fr = 'Application web full-stack construite avec React pour le frontend et le backend, développée pour Whirlpool. Inclut l''authentification des utilisateurs, des pages dédiées aux utilisateurs et administrateurs, l''intégration de base de données et un jeu interactif basé sur Unity.',
  description_fr = 'Plateforme web de niveau entreprise pour Whirlpool avec gestion complète des utilisateurs, tableaux de bord administratifs et intégration transparente de jeux Unity. Construit avec React et des technologies web modernes.'
WHERE code = 'PRJ-002';

UPDATE projects SET
  title_fr = 'App Banque Mobile',
  summary_fr = 'Application mobile multiplateforme pour la banque numérique avec React Native, intégration Firebase et API Plaid pour des transactions financières sécurisées.',
  description_fr = 'Solution bancaire mobile moderne avec gestion de compte en temps réel, historique des transactions et traitement sécurisé des paiements avec des protocoles de sécurité standard de l''industrie.'
WHERE code = 'PRJ-003';

UPDATE projects SET
  title_fr = 'Jeu Spatial de Survie',
  summary_fr = 'Shooter spatial arcade rapide construit avec JavaScript vanilla et HTML5 Canvas. Pilotez votre vaisseau à travers un champ de bataille sans fin, détruisez les ennemis, collectez des power-ups, déclenchez des trous noirs et affrontez un boss final.',
  description_fr = 'Jeu arcade de style rétro avec génération dynamique d''ennemis, difficulté progressive, systèmes de power-ups et batailles de boss épiques. Construit entièrement avec JavaScript vanilla pour des performances optimales.'
WHERE code = 'PRJ-004';


-- Experience Sections - French
UPDATE content_sections SET
  title_fr = 'Technologue Créatif',
  subtitle_fr = 'Focus Design & Ingénierie',
  body_fr = 'Actuellement concentré sur la création de designs numériques visuellement frappants, d''inspiration vintage et non conventionnels. J''explore l''intersection de l''esthétique et des systèmes, en construisant des expériences qui combinent front-end, back-end, bases de données et APIs avec une forte identité artistique. Mon travail est motivé par la créativité, l''expérimentation et l''objectif clair de rejoindre l''Apple Developer Academy.'
WHERE key = 'experience_01';

UPDATE content_sections SET
  title_fr = 'Projets Full-Stack et Informatique Appliquée',
  body_fr = 'Conçu et développé une plateforme web complète de zéro — frontend, backend, bases de données, APIs — et l''ai déployée publiquement. Travaillé avec Unity sur un projet industriel pour Whirlpool, intégrant des systèmes interactifs et des concepts d''informatique appliquée. Comme deuxième projet majeur, j''ai développé une application Swift pour Cáritas de Monterrey, combinant technologie, impact social et design centré sur l''utilisateur. Exploré des méthodes computationnelles avancées, programmation fonctionnelle avec Racket et Clojure, et résolution de problèmes complexes.'
WHERE key = 'experience_02';

UPDATE content_sections SET
  title_fr = 'Systèmes, Architecture et Informatique Bas Niveau',
  body_fr = 'Approfondi ma compréhension de la Programmation Orientée Objet en C++, de l''architecture logicielle et de la conception de systèmes web. Travaillé avec GitHub, exploré le langage assembleur et appliqué des concepts informatiques à la biologie computationnelle. Étudié les exigences logicielles, l''architecture web et l''architecture logicielle, renforçant mon approche de pensée systémique.'
WHERE key = 'experience_03';

UPDATE content_sections SET
  title_fr = 'Fondamentaux de l''Informatique',
  body_fr = 'Construit une base solide en HTML, CSS, C++ et Python, en me concentrant sur les fondamentaux du langage, les structures de données et les projets pratiques. Développé la pensée computationnelle, le raisonnement orienté objet et les compétences de résolution de problèmes à travers l''expérimentation pratique.'
WHERE key = 'experience_04';


-- ============================================
-- GERMAN TRANSLATIONS (DE)
-- ============================================

-- Projects - German
UPDATE projects SET
  title_de = 'Cáritas Spenden Swift App',
  summary_de = 'Eine moderne iOS-Lösung, die mit Swift entwickelt wurde, um Spendenabläufe, Basar-Koordination und Impact-Tracking durch Karten, Dashboards und intelligente Tools zu optimieren.',
  description_de = 'Umfassende iOS-Anwendung für Cáritas de Monterrey zur Optimierung des Spendenmanagements, Koordination von Basar-Operationen und Verfolgung sozialer Auswirkungen durch interaktive Karten und Daten-Dashboards.'
WHERE code = 'PRJ-001';

UPDATE projects SET
  title_de = 'Whirlpool Web-Plattform',
  summary_de = 'Full-Stack-Webanwendung, die mit React für Frontend und Backend entwickelt wurde, für Whirlpool. Umfasst Benutzerauthentifizierung, dedizierte Benutzer- und Admin-Seiten, Datenbankintegration und ein interaktives Unity-basiertes Spiel.',
  description_de = 'Unternehmensweite Web-Plattform für Whirlpool mit vollständiger Benutzerverwaltung, administrativen Dashboards und nahtloser Unity-Spielintegration. Entwickelt mit React und modernen Web-Technologien.'
WHERE code = 'PRJ-002';

UPDATE projects SET
  title_de = 'Mobile Banking App',
  summary_de = 'Plattformübergreifende Mobile-Anwendung für digitales Banking mit React Native, Firebase-Integration und Plaid-API für sichere Finanztransaktionen.',
  description_de = 'Moderne Mobile-Banking-Lösung mit Echtzeit-Kontoverwaltung, Transaktionshistorie und sicherer Zahlungsabwicklung mit branchenüblichen Sicherheitsprotokollen.'
WHERE code = 'PRJ-003';

UPDATE projects SET
  title_de = 'Weltraum-Überlebensspiel',
  summary_de = 'Rasanter Arcade-Weltraum-Shooter, entwickelt mit Vanilla JavaScript und HTML5 Canvas. Steuern Sie Ihr Schiff durch ein endloses Schlachtfeld, zerstören Sie Feinde, sammeln Sie Power-Ups, entfesseln Sie schwarze Löcher und stellen Sie sich einem Endboss.',
  description_de = 'Arcade-Spiel im Retro-Stil mit dynamischer Feindgenerierung, progressiver Schwierigkeit, Power-Up-Systemen und epischen Boss-Kämpfen. Vollständig mit Vanilla JavaScript für optimale Leistung entwickelt.'
WHERE code = 'PRJ-004';


-- Experience Sections - German
UPDATE content_sections SET
  title_de = 'Kreativer Technologe',
  subtitle_de = 'Fokus auf Design & Technik',
  body_de = 'Derzeit konzentriert auf die Gestaltung visuell beeindruckender, vintage-inspirierter und unkonventioneller digitaler Designs. Ich erforsche die Schnittstelle von Ästhetik und Systemen und baue Erlebnisse, die Frontend, Backend, Datenbanken und APIs mit einer starken künstlerischen Identität verbinden. Meine Arbeit wird von Kreativität, Experimenten und dem klaren Ziel angetrieben, der Apple Developer Academy beizutreten.'
WHERE key = 'experience_01';

UPDATE content_sections SET
  title_de = 'Full-Stack & Angewandte Informatik Projekte',
  body_de = 'Entwurf und Entwicklung einer kompletten Webplattform von Grund auf — Frontend, Backend, Datenbanken, APIs — und öffentlich bereitgestellt. Arbeit mit Unity an einem Industrieprojekt für Whirlpool, Integration interaktiver Systeme und angewandter Informatikkonzepte. Als zweites Hauptprojekt entwickelte ich eine Swift-Anwendung für Cáritas de Monterrey, die Technologie, soziale Auswirkungen und benutzerzentriertes Design verbindet. Erforschung fortgeschrittener Rechenmethoden, funktionale Programmierung mit Racket und Clojure und komplexe Problemlösung.'
WHERE key = 'experience_02';

UPDATE content_sections SET
  title_de = 'Systeme, Architektur & Low-Level-Computing',
  body_de = 'Vertiefung meines Verständnisses von Objektorientierter Programmierung in C++, Softwarearchitektur und Web-Systemdesign. Arbeit mit GitHub, Erforschung von Assemblersprache und Anwendung von Informatikkonzepten auf Computerbiologie. Studium von Softwareanforderungen, Webarchitektur und Softwarearchitektur, Stärkung meines systemischen Denkansatzes.'
WHERE key = 'experience_03';

UPDATE content_sections SET
  title_de = 'Grundlagen der Informatik',
  body_de = 'Aufbau einer soliden Basis in HTML, CSS, C++ und Python, mit Fokus auf Sprachgrundlagen, Datenstrukturen und praxisorientierte Projekte. Entwicklung von rechnerischem Denken, objektorientiertem Denken und Problemlösungsfähigkeiten durch praktische Experimente.'
WHERE key = 'experience_04';


-- ============================================
-- CREATE LANGUAGE-AWARE VIEWS (Recommended)
-- ============================================

-- Create a function to get projects in a specific language
CREATE OR REPLACE FUNCTION get_projects_by_language(lang TEXT DEFAULT 'en')
RETURNS TABLE (
  id bigint,
  code varchar,
  slug varchar,
  title text,
  summary text,
  description text,
  featured_image_url text,
  featured_image_alt varchar,
  project_type_id bigint,
  status text,
  external_url text,
  sort_order integer,
  is_featured boolean
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.id,
    p.code,
    p.slug,
    COALESCE(
      CASE 
        WHEN lang = 'es' THEN p.title_es
        WHEN lang = 'fr' THEN p.title_fr
        WHEN lang = 'de' THEN p.title_de
        ELSE p.title_en
      END,
      p.title
    ) as title,
    COALESCE(
      CASE 
        WHEN lang = 'es' THEN p.summary_es
        WHEN lang = 'fr' THEN p.summary_fr
        WHEN lang = 'de' THEN p.summary_de
        ELSE p.summary_en
      END,
      p.summary
    ) as summary,
    COALESCE(
      CASE 
        WHEN lang = 'es' THEN p.description_es
        WHEN lang = 'fr' THEN p.description_fr
        WHEN lang = 'de' THEN p.description_de
        ELSE p.description_en
      END,
      p.description
    ) as description,
    p.featured_image_url,
    p.featured_image_alt,
    p.project_type_id,
    p.status::text,
    p.external_url,
    p.sort_order,
    p.is_featured
  FROM projects p;
END;
$$ LANGUAGE plpgsql;


-- Create a function to get content sections in a specific language
CREATE OR REPLACE FUNCTION get_content_sections_by_language(lang TEXT DEFAULT 'en')
RETURNS TABLE (
  id bigint,
  key varchar,
  title text,
  subtitle text,
  time_range varchar,
  body text,
  status text,
  sort_order integer
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    cs.id,
    cs.key,
    COALESCE(
      CASE 
        WHEN lang = 'es' THEN cs.title_es
        WHEN lang = 'fr' THEN cs.title_fr
        WHEN lang = 'de' THEN cs.title_de
        ELSE cs.title_en
      END,
      cs.title
    ) as title,
    COALESCE(
      CASE 
        WHEN lang = 'es' THEN cs.subtitle_es
        WHEN lang = 'fr' THEN cs.subtitle_fr
        WHEN lang = 'de' THEN cs.subtitle_de
        ELSE cs.subtitle_en
      END,
      cs.subtitle
    ) as subtitle,
    cs.time_range,
    COALESCE(
      CASE 
        WHEN lang = 'es' THEN cs.body_es
        WHEN lang = 'fr' THEN cs.body_fr
        WHEN lang = 'de' THEN cs.body_de
        ELSE cs.body_en
      END,
      cs.body
    ) as body,
    cs.status::text,
    cs.sort_order
  FROM content_sections cs;
END;
$$ LANGUAGE plpgsql;


-- ============================================
-- USAGE EXAMPLES
-- ============================================

-- Get projects in Spanish:
-- SELECT * FROM get_projects_by_language('es');

-- Get content sections in French:
-- SELECT * FROM get_content_sections_by_language('fr');

-- Get projects in German:
-- SELECT * FROM get_projects_by_language('de');
