"use client"

import { cn } from "@/lib/utils"
import DotPattern from "@/components/ui/dot-pattern"
import { useEffect, useMemo, useState } from "react"
import { useTranslation } from "@/lib/translations"
import Image from "next/image"
import { supabase, isSupabaseConfigured } from "@/lib/supabase"
import { NowPlayingCard, type NowPlayingTrack } from "@/components/ui/now-playing-card"
import { PhotoWidget } from "@/components/ui/photo-widget"
import { ChevronLeft, ChevronRight } from "lucide-react"

interface Experience {
  period: string
  role: string
  focus?: string
  desc: string
  skills: string[]
}

type ExperienceRow = {
  id: number
  key: string
  title: string
  subtitle: string | null
  time_range: string | null
  body: string
  sort_order: number
  section_highlights?: { text: string; sort_order: number }[]
  content_section_tags?: { section_tags?: { name?: string } | null }[]
}

function ExperienceCard({ experience, index, totalCards }: { experience: Experience; index: number; totalCards: number }) {
  const isCurrent = index === totalCards - 1

  return (
    <div
      className={cn(
        "group relative flex flex-col gap-3 rounded-xl border border-white/5 bg-white/5 p-4 sm:p-6 backdrop-blur-sm transition-all duration-300",
        "hover:-translate-y-1 hover:border-white/20 hover:bg-white/10 hover:shadow-[0_0_30px_-5px_rgba(255,255,255,0.1)]"
      )}
    >
      <div className="absolute -left-px -top-px h-2 w-2 bg-white opacity-0 transition-opacity group-hover:opacity-100" />
      <div className="absolute -bottom-px -right-px h-2 w-2 bg-white opacity-0 transition-opacity group-hover:opacity-100" />

      <div className="flex items-center justify-between">
        <span className={cn(
          "text-xs font-medium tracking-wider font-open-sans-custom",
          isCurrent ? "text-white" : "text-gray-400"
        )}>
          {experience.period}
        </span>
        {isCurrent && (
          <span className="relative flex h-2 w-2">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
            <span className="relative inline-flex rounded-full h-2 w-2 bg-green-500"></span>
          </span>
        )}
      </div>

      <div className="space-y-2">
        <h3 className="text-base sm:text-lg font-semibold text-white [text-shadow:_0_2px_8px_rgb(0_0_0_/_40%)] font-open-sans-custom">
          {experience.role}
          {experience.focus && (
            <span className="block text-xs sm:text-sm font-normal text-gray-400 mt-1">
              {experience.focus}
            </span>
          )}
        </h3>
        
        <p className="text-xs sm:text-sm leading-relaxed text-gray-300/90 font-open-sans-custom">
          {experience.desc}
        </p>
      </div>

      <div className="mt-2 flex flex-wrap gap-2">
        {experience.skills.map((skill, i) => (
          <span
            key={i}
            className="rounded-md border border-white/10 bg-black/20 px-2 py-1 text-[10px] uppercase tracking-wider text-gray-300 font-open-sans-custom transition-colors group-hover:border-white/20 group-hover:text-white"
          >
            {skill}
          </span>
        ))}
      </div>
    </div>
  )
}

export function ExperienceSection({
  nowPlaying,
  isPlaying = false,
  onTogglePlay,
  onNextTrack,
  onPrevTrack,
  currentTime = 0,
  duration = 0,
}: {
  nowPlaying?: NowPlayingTrack
  isPlaying?: boolean
  onTogglePlay?: () => void
  onNextTrack?: () => void
  onPrevTrack?: () => void
  currentTime?: number
  duration?: number
}) {
  const { t, language } = useTranslation()
  const [experiences, setExperiences] = useState<Experience[] | null>(null)
  const [loadError, setLoadError] = useState<string | null>(null)
  const [currentTechIndex, setCurrentTechIndex] = useState(0)

  const techCategories = useMemo(() => [
    {
      titleKey: "coreTech",
      techs: ["Next.js", "React", "TypeScript", "SwiftUI"]
    },
    {
      titleKey: "systemsLogic",
      techs: ["Node.js", "Python", "C++", "Clojure", "Racket"]
    },
    {
      titleKey: "dataInfra",
      techs: ["SQL / Databases", "APIs (REST)", "Auth (JWT)"]
    },
    {
      titleKey: "creativeSimulation",
      techs: ["Unity", "WebGL / Three.js", "Simulation & Modeling"]
    }
  ], [])

  useEffect(() => {
    let isMounted = true

    const loadExperiences = async () => {
      if (!isSupabaseConfigured) {
        setLoadError("Supabase not configured")
        return
      }

      try {
        const { data, error } = await supabase
          .from("content_sections")
          .select(`
            id,
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
            sort_order,
            section_highlights ( text, sort_order ),
            content_section_tags ( section_tags ( name ) )
          `)
          .eq("status", "active")
          .ilike("key", "experience_%")
          .order("sort_order", { ascending: true })

        if (!isMounted) return
        if (error) {
          setLoadError(error.message)
          return
        }

        const rows = Array.isArray(data) ? data : []
        const mapped = rows.map((row) => {
          const item = row as any
          const highlights = item.section_highlights?.length
              ? [...item.section_highlights].sort((a: any, b: any) => a.sort_order - b.sort_order).map((h: any) => h.text)
              : []
          const tags = item.content_section_tags?.map((tag: any) => tag.section_tags?.name).filter(Boolean) as string[] | undefined

          // Get localized field based on current language
          const getLocalizedField = (fieldPrefix: string) => {
            const langField = item[`${fieldPrefix}_${language}`]
            const enField = item[`${fieldPrefix}_en`]
            const defaultField = item[fieldPrefix]
            return langField || enField || defaultField || ''
          }

          return {
            period: item.time_range ?? "",
            role: getLocalizedField('title'),
            focus: getLocalizedField('subtitle') || undefined,
            desc: getLocalizedField('body'),
            skills: highlights.length > 0 ? highlights : tags ?? [],
          }
        })
        setExperiences(mapped)
      } catch (err) {
        setLoadError(err instanceof Error ? err.message : "Failed to load experiences")
      }
    }

    loadExperiences()
    return () => { isMounted = false }
  }, [language])

  const experiencesToRender = experiences ?? []

  return (
    <div className="relative mx-auto w-full max-w-6xl px-4 pb-20 pt-4 md:px-6 lg:px-10">
      
      <div className="flex flex-col lg:grid lg:grid-cols-[1fr_1.5fr] gap-8 lg:gap-16 lg:items-start">
        
        {/* Left Column: Static Info */}
        <div className="flex flex-col gap-6 md:gap-8 order-1 lg:order-none">
            
          {/* Profile Picture Section */}
          <div className="relative aspect-square w-40 sm:w-48 mx-auto lg:mx-0 overflow-hidden rounded-xl border border-white/10 bg-white/5 backdrop-blur-sm group/profile">
            <DotPattern width={16} height={16} cx={1} cy={1} cr={1} className="absolute inset-0 -z-10 opacity-30 fill-white/20" />
            <Image src="/placeholder-user.jpg" alt="Profile photo" fill className="object-cover opacity-90 transition-opacity duration-500 group-hover/profile:opacity-0" priority />
            <Image src="/profile-hover.png" alt="Profile photo hover" fill className="object-cover opacity-0 transition-opacity duration-500 group-hover/profile:opacity-90" />
            <div className="absolute -left-1 -top-1 h-3 w-3 border-l border-t border-white/40" />
            <div className="absolute -bottom-1 -right-1 h-3 w-3 border-b border-r border-white/40" />
          </div>

          <div className="relative text-center lg:text-left">
            <p className="mb-3 md:mb-4 text-xs uppercase tracking-[0.2em] text-gray-500 font-open-sans-custom">{t("background")}</p>
            <h2 className="mb-4 md:mb-6 text-3xl sm:text-4xl font-bold tracking-tight text-white [text-shadow:_0_4px_30px_rgb(255_255_255_/_10%)] font-open-sans-custom md:text-5xl">{t("experience")}</h2>
            <p className="max-w-md mx-auto lg:mx-0 text-sm sm:text-base leading-relaxed text-gray-400 font-open-sans-custom">{t("experienceIntro")}</p>

            <div className="mt-6 md:mt-10 flex flex-col gap-6 md:gap-8 font-open-sans-custom">
              
              {/* Education */}
              <div className="relative border-l border-white/10 pl-4">
                <h4 className="mb-2 text-xs font-bold text-white uppercase tracking-widest">{t("education")}</h4>
                <p className="text-gray-200 text-sm font-semibold">Tecnológico de Monterrey</p>
                <p className="text-xs text-gray-500">{t("degree")}</p>
              </div>
              
              {/* Tech Stack - Desktop: All Categories */}
              <div className="hidden lg:block relative border-l border-white/10 pl-4 space-y-4">
                {techCategories.map((category) => (
                  <div key={category.titleKey}>
                    <h4 className="mb-2 text-[10px] font-bold text-white uppercase tracking-widest">{t(category.titleKey as any)}</h4>
                    <div className="flex flex-wrap justify-start gap-2 max-w-full lg:max-w-xs">
                      {category.techs.map((tech) => (
                        <span key={tech} className="rounded-full border border-white/10 bg-white/5 px-2.5 sm:px-3 py-1 text-[9px] sm:text-[10px] uppercase text-gray-300 transition-colors hover:border-white/30 hover:bg-white/10">
                          {tech}
                        </span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>

              {/* Tech Stack - Mobile: Carousel (UPDATED: Centered & Purple) */}
              <div className="lg:hidden relative border-l border-white/10 pl-4">
                
                {/* Header with Navigation (Centered) */}
                <div className="flex items-center justify-center gap-4 mb-4">
                  <h4 
                    key={currentTechIndex}
                    className="text-[10px] font-bold text-white uppercase tracking-widest animate-in fade-in slide-in-from-left-2 duration-300"
                  >
                    {t(techCategories[currentTechIndex].titleKey as any)}
                  </h4>
                  
                  {/* Navigation Buttons */}
                  <div className="flex items-center gap-2">
                    {/* Previous Button */}
                    <button
                      onClick={() => setCurrentTechIndex((prev) => (prev === 0 ? techCategories.length - 1 : prev - 1))}
                      className="flex h-7 w-7 items-center justify-center rounded-full border border-white/10 bg-white/5 text-white/60 hover:bg-white/10 hover:text-white transition-all active:scale-95"
                      aria-label="Previous category"
                    >
                      <ChevronLeft className="h-3 w-3" />
                    </button>
                    
                    {/* Next Button (Glowing Purple) */}
                    <button
                      onClick={() => setCurrentTechIndex((prev) => (prev === techCategories.length - 1 ? 0 : prev + 1))}
                      className="group relative flex h-7 w-7 items-center justify-center rounded-full border border-white/20 bg-white/10 text-white transition-all active:scale-95"
                      aria-label="Next category"
                    >
                      <ChevronRight className="h-3 w-3 relative z-10" />
                      {/* Shining/Glowing Effect (Purple) */}
                      <div className="absolute inset-0 rounded-full bg-purple-500/40 blur-[4px] animate-pulse" />
                      <div className="absolute inset-0 rounded-full border border-purple-500/50 opacity-70" />
                    </button>
                  </div>
                </div>
                
                {/* Carousel Content (Centered) */}
                <div className="min-h-[60px]">
                  <div className="flex flex-wrap justify-center gap-2">
                    {techCategories[currentTechIndex].techs.map((tech) => (
                      <span key={tech} className="rounded-full border border-white/10 bg-white/5 px-2.5 py-1 text-[9px] uppercase text-gray-300 animate-in zoom-in-95 duration-200">
                        {tech}
                      </span>
                    ))}
                  </div>
                </div>
                
                {/* Dots indicator (Centered & Purple) */}
                <div className="flex justify-center gap-1.5 mt-4">
                  {techCategories.map((_, idx) => (
                    <button
                      key={idx}
                      onClick={() => setCurrentTechIndex(idx)}
                      className={cn(
                        "h-1 rounded-full transition-all duration-300",
                        idx === currentTechIndex ? "w-4 bg-purple-400" : "w-1.5 bg-white/20"
                      )}
                      aria-label={`Go to ${t(techCategories[idx].titleKey as any)}`}
                    />
                  ))}
                </div>
              </div>

              {/* Now Playing */}
              {nowPlaying && (
                <div className="relative border-l border-white/10 pl-4">
                  <NowPlayingCard
                    track={nowPlaying}
                    isPlaying={isPlaying}
                    onToggle={onTogglePlay ?? (() => {})}
                    onNext={onNextTrack}
                    onPrev={onPrevTrack}
                    currentTime={currentTime}
                    duration={duration}
                  />
                </div>
              )}

              {/* Photo Widget (desktop only) */}
              <div className="hidden lg:block relative border-l border-white/10 pl-4">
                <PhotoWidget albumKey="about-widget" />
              </div>

            </div>
          </div>
        </div>

        {/* Right Column: Experience Cards */}
        <div className="flex flex-col gap-4 order-2 lg:order-none">
          {[...experiencesToRender].reverse().map((experience, index) => (
            <ExperienceCard key={index} experience={experience} index={index} totalCards={experiencesToRender.length} />
          ))}
        </div>

        {/* Photo Widget (mobile only) */}
        <div className="lg:hidden order-3 relative border-l border-white/10 pl-4">
          <PhotoWidget albumKey="about-widget" />
        </div>

      </div>

      {loadError && (
        <p className="mt-6 text-center text-xs text-gray-500 font-open-sans-custom">
          {loadError}
        </p>
      )}
    </div>
  )
}