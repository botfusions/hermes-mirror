# Manual Social Reply Agent Pattern

Use this reference when Cenk wants a short test agent that monitors X/Twitter but does **not** post.

## Pattern

- Create a bounded cron job rather than a permanent profile first.
- Use the existing research profile when available, e.g. `hakan` for GEO/AI research.
- Limit scope to a named handle list and a narrow topic filter.
- Deliver only a report with source links and reply suggestions.
- Keep platform writes disabled: no post, reply, like, repost, follow, or DM.
- Cenk manually posts any selected reply.

## Output constraints

- Keep suggestions under the user's account limit; for non-blue X accounts use <=140 characters.
- One suggested reply per author per day unless Cenk explicitly changes the rule.
- Avoid salesy copy, links, hashtag stuffing, and generic “I agree” replies.
- Include why the reply fits the tweet.

## State tracking

Use a small local JSON file to prevent duplicates:

```json
{
  "agent": "Adem",
  "runs": [],
  "suggested_tweets": [
    {"date": "YYYY-MM-DD", "handle": "@name", "tweet_url": "https://x.com/...", "reply": "..."}
  ]
}
```

## Example: Adem GEO test

- Job name: `adem-geo-tweet-reply-test`.
- Scope: GEO / AI search / AI visibility tweets from Cenk's tracked account list.
- Duration: 3 daily runs.
- Delivery: Telegram/current origin report.
- Wiki/state files live under Hakan Wiki.
