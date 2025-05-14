import { BlogPosts, PromptPosts } from 'app/components/posts'

export default function Page() {
  return (
    <section>
      <h1 className="mb-8 text-2xl font-semibold tracking-tighter">
        Yazan's ramblings
      </h1>
      <p className="mb-4">
        {`My wife works in marketing. She told me I have to have a blog. Something about SEO and organic reach. So here it is. Had to park it on a seperate CNAME because of Next.js though. Wife wrote them an email asking them to “please fix”. Here’s hoping. `}
      </p>
      <div className="my-8">
        <BlogPosts />
        <PromptPosts />

      </div>
    </section>
  )
}
