# 988 Suicide & Crisis Lifeline

A single-page recreation of the 988 Lifeline website with an integrated AI-powered crisis support chatbot built with Next.js, React, Tailwind CSS, and Claude AI.

## Features

- **Responsive Design**: Fully responsive layout that works on all devices
- **Crisis Resources**: Quick access to call, text, and chat options for 988
- **Warning Signs**: Educational content about suicide prevention and warning signs
- **AI Chatbot**: Claude-powered chatbot trained as a suicide prevention specialist
  - Provides empathetic, 24/7 support
  - Offers mental health resources
  - Encourages professional help when appropriate
  - Non-judgmental and supportive responses

## Getting Started

### Prerequisites

- Node.js 18.17 or later
- An Anthropic API key (for the chatbot functionality)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/MichaelPopeDeveloper/998lifeline-client.git
cd 998lifeline-client
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env.local
```

4. Add your Anthropic API key to `.env.local`:
```
ANTHROPIC_API_KEY=your_anthropic_api_key_here
```

5. Run the development server:
```bash
npm run dev
```

6. Open [http://localhost:3000](http://localhost:3000) in your browser

## Chatbot Features

The integrated chatbot is powered by Claude 3.5 Sonnet and trained to:

- Provide compassionate, non-judgmental support
- Recognize crisis situations and encourage immediate professional help
- Share mental health resources including:
  - 988 Suicide & Crisis Lifeline
  - Veterans Crisis Line
  - Crisis Text Line
  - Trevor Project (LGBTQ+ youth)
  - Trans Lifeline
  - SAMHSA National Helpline
- Help with safety planning and coping strategies
- Validate feelings while providing hope

## Tech Stack

- **Framework**: Next.js 16
- **UI**: React 19, Tailwind CSS 4
- **AI**: Claude 3.5 Sonnet via Anthropic SDK
- **Language**: TypeScript

## Important Note

This chatbot is designed to provide supportive conversations and resources, but it is **NOT a replacement for professional crisis counseling**. Users experiencing a crisis should:

- **Call or text 988** for the National Suicide Prevention Lifeline
- **Call 911** if in immediate danger
- Visit the nearest emergency room

## Project Structure

```
├── src/
│   ├── app/
│   │   ├── api/chat/        # API route for chatbot
│   │   ├── layout.tsx       # Root layout
│   │   ├── page.tsx         # Main landing page
│   │   └── globals.css      # Global styles
│   └── components/
│       └── Chatbot.tsx      # Chat UI component
├── .env.local               # Environment variables (not committed)
└── package.json
```

## API Routes

### POST /api/chat

Handles chatbot conversations with Claude AI.

**Request:**
```json
{
  "messages": [
    { "role": "user", "content": "Hello" },
    { "role": "assistant", "content": "Hi, how are you?" }
  ]
}
```

**Response:**
```json
{
  "message": "I'm here to support you..."
}
```

## Deploy on Vercel

The easiest way to deploy this app is to use the [Vercel Platform](https://vercel.com/new).

Make sure to add your `ANTHROPIC_API_KEY` environment variable in the Vercel project settings.

## License

This project is created for educational and demonstration purposes.

## Resources

- [988 Suicide & Crisis Lifeline](https://988lifeline.org/)
- [Anthropic Claude Documentation](https://docs.anthropic.com/)
- [Next.js Documentation](https://nextjs.org/docs)

---

**If you or someone you know is experiencing a mental health crisis, please call or text 988 for immediate support.**
