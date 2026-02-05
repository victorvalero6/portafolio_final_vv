import { createClient } from "@supabase/supabase-js"

const supabaseUrl =
  process.env.NEXT_PUBLIC_SUPABASE_URL ?? "https://mvfngwkmnyszsaewksyi.supabase.co"
const supabaseAnonKey =
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ??
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im12Zm5nd2ttbnlzenNhZXdrc3lpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAwODc4NzEsImV4cCI6MjA4NTY2Mzg3MX0.fz8LZZVvuuYkGuItw5biVH_2TfJriSjx70etzIum2bU"

export const isSupabaseConfigured = Boolean(supabaseUrl && supabaseAnonKey)
export const supabase = createClient(supabaseUrl, supabaseAnonKey)
