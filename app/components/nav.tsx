'use client'
import Link from 'next/link'
import { usePathname } from 'next/navigation'

const navItems = {
  '/': 'home',
  '/blog': 'blog',
  '/prompt': 'prompts',
}

export function Navbar() {
  const pathname = usePathname()
  return (
    <div className="fixed bottom-12 left-1/2 z-50 -translate-x-1/2">
      <nav className="flex items-center rounded-sm border border-border bg-background p-1 shadow-2xl">
        {Object.entries(navItems).map(([path, name]) => {
          const isActive =
            pathname === path || (path !== '/' && pathname.startsWith(path))
          return (
            <Link
              key={path}
              href={path}
              className={`px-3 py-2 font-mono text-[9px] tracking-[0.2em] uppercase transition-all sm:px-4 ${
                isActive
                  ? 'bg-muted text-primary'
                  : 'text-muted-foreground hover:text-foreground'
              }`}
            >
              {name}
            </Link>
          )
        })}
      </nav>
    </div>
  )
}
