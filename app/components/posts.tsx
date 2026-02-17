import Link from 'next/link'
import { formatDate, getBlogPosts } from 'app/blog/utils'
import { getPrompts } from 'app/prompt/utils'

function TypePill({ type }: { type: 'essay' | 'prompt' }) {
  const isEssay = type === 'essay'
  return (
    <span
      style={
        isEssay
          ? {
              backgroundColor: 'oklch(0.63 0.24 35 / 0.12)',
              color: 'var(--primary)',
              borderColor: 'oklch(0.63 0.24 35 / 0.3)',
            }
          : {
              backgroundColor: 'oklch(0.55 0 0 / 0.08)',
              color: 'var(--muted-foreground)',
              borderColor: 'oklch(0.55 0 0 / 0.2)',
            }
      }
      className="inline-flex items-center self-center px-1.5 py-0.5 rounded-sm border text-[10px] font-medium tracking-widest uppercase leading-none shrink-0 mr-3"
    >
      {isEssay ? 'essay' : 'prompt'}
    </span>
  )
}

export function BlogPosts() {
  let allBlogs = getBlogPosts()

  return (
    <div>
      {allBlogs
        .sort((a, b) => {
          if (
            new Date(a.metadata.publishedAt) > new Date(b.metadata.publishedAt)
          ) {
            return -1
          }
          return 1
        })
        .map((post) => (
          <Link
            key={post.slug}
            className="flex flex-col space-y-1 mb-4"
            href={`/blog/${post.slug}`}
          >
            <div className="w-full flex flex-col md:flex-row space-x-0 md:space-x-2">
              <p className="text-neutral-600 dark:text-neutral-400 w-[100px] tabular-nums shrink-0">
                {formatDate(post.metadata.publishedAt, false)}
              </p>
              <div className="flex items-baseline gap-0">
                <TypePill type="essay" />
                <p className="text-neutral-900 dark:text-neutral-100 tracking-tight">
                  {post.metadata.title}
                </p>
              </div>
            </div>
          </Link>
        ))}
    </div>
  )
}
export function PromptPosts() {
  let allPrompts = getPrompts()

  return (
    <div>
      {allPrompts
        .map((post) => (
          <Link
            key={post.slug}
            className="flex flex-col space-y-1 mb-4"
            href={`/prompt/${post.slug}`}
          >
            <div className="w-full flex flex-col md:flex-row space-x-0 md:space-x-2">
              <p className="text-neutral-600 dark:text-neutral-400 w-[100px] tabular-nums shrink-0">
                {post.metadata.type}
              </p>
              <div className="flex items-baseline gap-0">
                <TypePill type="prompt" />
                <p className="text-neutral-900 dark:text-neutral-100 tracking-tight">
                  {post.metadata.title}
                </p>
              </div>
            </div>
          </Link>
        ))}
    </div>
  )
}