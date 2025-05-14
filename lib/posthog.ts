import { PostHog } from "posthog-node"

/**
 * Initializes and returns a PostHog Node.js client.
 *
 * Uses environment variables for configuration:
 * - NEXT_PUBLIC_POSTHOG_KEY: your PostHog project API key
 * - NEXT_PUBLIC_POSTHOG_HOST: your PostHog host URL
 */
export default function PostHogClient() {
  const posthogClient = new PostHog(process.env.NEXT_PUBLIC_POSTHOG_KEY!, {
    host: process.env.NEXT_PUBLIC_POSTHOG_HOST,
    flushAt: 1,
    flushInterval: 0,
  })

  return posthogClient
}
