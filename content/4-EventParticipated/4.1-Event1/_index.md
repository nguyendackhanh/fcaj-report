---
title: "Event 1: FCAJ Community Day 2026"
date: 2026-05-09
weight: 1
chapter: false
pre: " <b> 4.1. </b> "
---

### Event Purpose

- **Improving Study Methods:** Providing guidance on how to "hack your brain" to maintain study motivation and make learning as engaging as playing games.
- **Enhancing AI Skills:** Sharing optimal Prompt Engineering methods to interact effectively with LLMs and avoid AI hallucination.
- **Practical Career Orientation:** Offering insights from an employer's perspective on candidate evaluation, the importance of foundational knowledge, and integrity in the workplace, especially in the AI era.

---

### Key Highlights

#### 1. Brain Hacking for Study Addiction (Dopamine-Driven Learning) - *Speaker: Mr. Huỳnh Hoàng Long*
- **The Problem:** Social media and games offer instant gratification and curiosity, causing the brain to continuously release dopamine. Meanwhile, studying typically yields slow results.
- **The Solution:** 
  - Trick the brain by creating small, random rewards after each study session (e.g., drawing a random reward after 10 minutes of studying).
  - Use the **fear of loss**: Maintain a daily learning streak on a calendar, as humans naturally fear losing what they have built up.
  - **The 2-Minute Rule:** If a task takes less than 2 minutes, do it immediately without procrastination.
  - Break down large goals to avoid feeling overwhelmed (e.g., studying one small AWS service per day instead of cramming for 5 hours).

#### 2. Ultimate Prompt Engineering: Enhancing LLM Output Quality - *Speaker: Mr. Nguyễn Tuấn Thịnh*
- **Prompt Design Skills:** For optimal AI responses, provide 7 key components: Role, Instruction, Context, Input, Output format, Examples, and Constraints.
- **Advanced Techniques:** Utilize *Chain of Thought* (step-by-step reasoning) or *Tree of Thought*. Avoid negative phrasing ("do not") to minimize AI hallucination.
- **Practical Demo - Proptimizer:** An application built on AWS to optimize prompts. The architecture uses:
  - **Frontend:** S3 & CloudFront (CDN).
  - **Auth:** Amazon Cognito.
  - **Backend (Serverless):** API Gateway & AWS Lambda.
  - **Database & AI:** DynamoDB for history and Amazon Bedrock for AI Foundation models.

#### 3. Why Haven't You Started Working Yet? - Employer's Perspective - *Speaker: Mr. Nguyễn Khang (Solutions Architect at Cloud Kinetics)*
- **Foundational Thinking:** Technology constantly changes; you don't need to know every framework or service. The most important thing is a solid foundation and a strong problem-solving thought process.
- **AI as an Amplifier:** AI makes good engineers better and exposes poor ones. If you use AI to complete a task without truly understanding the "Why," employers will notice. Understanding cannot be outsourced to AI.
- **Top 5 Recruitment Criteria for Freshers:**
  1. Attitude (Most crucial for freshers).
  2. Education/Qualifications.
  3. Skills.
  4. Experience vs. Exposure (You may lack years of experience, but exposure to diverse projects is a huge plus).
  5. Innate qualities (Natural abilities).
- **Integrity:** Always do the right thing and follow through, even when no one is watching. Maintain a long-term vision and avoid working in silos.

#### 4. Automated Software Development with AI Agents (BMX Method) - *Speaker: Ms. Thảo (Software Developer at VIB)*
- **Current State of AI Coding:** Chatting directly with AI (like ChatGPT) without a clear system architecture often leads to spaghetti code, context forgetting (hallucination), and maintenance difficulties.
- **BMX Method:** An open-source solution that divides work into small tasks adhering to the Software Development Life Cycle (SDLC).
- **Multi-Agent Ecosystem:**
  - **PM Agent:** Analyzes ideas and automatically generates Product Requirement Documents (PRD).
  - **Architect Agent:** Based on the PRD, designs the System Architecture and selects appropriate technologies.
  - **Scrum Master / BO Agent:** Breaks down Epics into Stories and manages the state flow (Draft -> Approve -> Block -> Review).
  - **Developer Agent:** Automatically picks up approved stories, writes code, and updates statuses.
  - **QA/Review Agent:** Automatically tests code, iterating in a continuous feedback loop until the bug count is zero.
- **Advantages:** Reduces the context window load for each agent, prevents AI from being overwhelmed with noise, and easily scales while allowing human-in-the-loop intervention.

---
#### Some photos from the event
![Event Picture 1](/images/event/event%201/event1-1.jpg?v=20260710)
![Event Picture 2](/images/event/event%201/event1-2.jpg?v=20260710)
![Event Picture 3](/images/event/event%201/event1-3.jpg?v=20260710)
### What I Learned
- Understood the dopamine mechanism to self-motivate daily AWS study sessions without feeling bored or overwhelmed.
- Learned how to optimize prompts when using AI and visualized a real-world Serverless AI architecture on AWS (S3, API Gateway, Lambda, Bedrock).
- Realized the importance of deeply understanding the root of a problem (asking "Why" repeatedly) rather than just superficially learning tools. Attitude and integrity are the keys to advancing in this career.
