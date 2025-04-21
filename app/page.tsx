import { BlogPosts } from 'app/components/posts'

export default function Page() {
  return (
    <section>
      <h1 className="mb-8 text-2xl font-semibold tracking-tighter">
        Yazan's ramblings
      </h1>
      <p className="mb-4">
        {`Welcome to the blog part of my site! It's a seperate app from my dashboard since static and dynamic routes in Next.js were harder to get properly working than it was worth. Vercel, please fix.  `}
      </p>
      <div className="my-8">
        <BlogPosts />
      </div>
    </section>
  )
}
