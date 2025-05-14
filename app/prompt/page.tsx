import { PromptPosts } from 'app/components/posts'

export const metadata = {
  title: 'Prompts',
  description: 'Find All My Saved Prompts.',
}

export default function Page() {
  return (
    <section>
      <h1 className="font-semibold text-2xl mb-8 tracking-tighter">Prompts</h1>
      <PromptPosts />
    </section>
  )
}
