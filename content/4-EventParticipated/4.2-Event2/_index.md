---
title: "Event 2: AWS Community Day 2026"
date: 2026-05-23
weight: 2
chapter: false
pre: " <b> 4.2. </b> "
---
#### Some photos from the event
![Event Picture 1](/images/event/event%202/event2-1.jpg?v=20260710)
![Event Picture 2](/images/event/event%202/event2-2.jpg?v=20260710)
![Event Picture 3](/images/event/event%202/event2-3.jpg?v=20260710)



### Event Objectives

- **Acquire Cutting-Edge Tech Insights:** Learn modern cloud architecture paradigms, optimize global Content Delivery Networks (CDNs), and enhance enterprise cloud infrastructure security.
- **Study Next-Gen Generative AI Applications:** Deep dive into Context Engineering, non-determinism in LLMs, and enterprise-grade Multi-Agent Systems.
- **Career Planning & Networking:** Learn from seasoned experts' real-world stories and connect with the active AWS Vietnam community.

---

### Speakers

- **Tín Trương** – Platform Engineer at Gotadi (Speaker for *"Context Is Everything"*)
- **UTMorpho Dev Team** – LotusHacks Hackathon Winners (Speakers for *"36 hrs with LotusHacks"*)
- **AWS Infrastructure Expert** – AWS Solutions Architect (Speaker for *"From Edge To Origin: CloudFront"*)
- **AWS Data Solutions Specialist** – AWS Tech Specialist (Speaker for *"Friendly AI Assistant with Amazon Quick"*)
- **Đức Đào** – Cloud Phoenix Specialist (Speaker for *"Non-Determinism of LLM Settings"*)
- **AI Solutions Architect** – Enterprise Systems Architect (Speaker for *"Enterprise-Grade Multi-Agent System"*)

---

### Key Highlights

#### 1. Context Engineering & Future Tech Trends
- **The Power of Context:** LLMs have massive general knowledge but fail (yielding generic or hallucinated answers) without detailed context. Context Engineering—such as defining specific user roles—produces vastly superior results compared to dumping massive, cluttered documents that clog the attention window.
- **Second AI Brain:** The paradigm shift from real-time prompt drafting to persistent long-term memories by integrating note-taking software (Obsidian) with AI for automated data retrieval.
- **Jevons Paradox in the AI Era:** As technology reduces software development costs (0 to 1), the absolute volume of software will explode. Job opportunities will shift heavily toward operating, securing, integrating, and scaling systems from 1 to N.

#### 2. 36 hrs with LotusHacks – Building UTMorpho from Idea to Reality
- **Hackathon Sprint & Brainstorming:** Real-world experiences of starting from scratch to create a novel idea at LotusHacks under intense constraints.
- **Product Shaping & pressure development:** Defining practical user pain points, framing the UTMorpho application architecture, and navigating technical failures during a non-stop 36-hour sprint.
- **MVP Demo & Key Turning Points:** Presenting the UTMorpho functional overview, learning from setbacks, and charting the future roadmap.

#### 3. Infrastructure Optimization at the Edge (Amazon CloudFront)
- **CloudFront as a Foundation:** Acting as a high-performance Content Delivery Network (CDN) to serve static and dynamic resources worldwide with minimal latency.
- **Cost & Speed Improvements:** Caching and compressing data at edge locations to drastically reduce bandwidth charges and load on origin servers.
- **Edge Security:** Integrating AWS WAF and AWS Shield directly at edge zones to shield the system from DDoS and malicious attacks before they reach core servers.

#### 4. Intelligent AI Assistants via Amazon Quick
- **Quick Chat & Quick Flows:** Leveraging virtual assistants to query raw data and build smart automated workflows (No-code) using natural language.
- **Quick Spaces & Quick Sight:** Collaboration vaults for knowledge sharing and interactive dashboard generation through conversational queries.

#### 5. The Deep Mechanics of Non-Determinism in LLMs
- **Token Prediction:** LLMs predict subsequent tokens using logits probability scoring.
- **Debunking the `Temperature = 0` Myth:** Setting temperature to 0 does not guarantee 100% identical responses across separate API runs. GPU-level floating-point parallel computation optimizations introduce tiny calculation ordering variations, which accumulate and drift outputs for complex logic tasks.

#### 6. Enterprise Multi-Agent Systems & Credit Scoring
- **Multi-Agent Paradigm:** Solving complex tasks by delegating specific roles, goals, and backstories to multiple specialized agents (Financial Collector, Risk Analyst, Decision Maker) instead of a single agent.
- **Model Context Protocol (MCP):** A unified standard connecting LLMs to data sources, streamlining complex $M \times N$ system integrations down to a clean $M + N$ model.

---

### Key Takeaways

#### Design Mindset
- **Edge-First & Well-Architected Systems:** Placing performance, cost optimization, and multi-layered security at the edge as core design principles.
- **Multi-Agent Coordination & Human-in-the-Loop:** Developing specialized AI agents while maintaining humans in a managerial (reviewing and approving) role.
- **Designing for Unpredictability:** Accepting that LLM outputs can vary slightly and writing automated testing wrappers to validate chatbot performance.

#### Technical Architecture
- Applying the Model Context Protocol (MCP) to streamline enterprise data API integration with LLMs.
- Implementing advanced context engineering and external persistent memory (Second AI Brain) to control output quality.
- Mitigating LLM non-determinism by using `Temperature = 0.1` to avoid the infinite loops of Greedy Decoding, and adjusting `repeat_penalty` for self-hosted models.

#### Enterprise Workflows
- Moving from proof-of-concept (POC) to production requires strict compliance and rigid security standards.
- **The Copy-Paste Code Trap:** AI gets you from 0 to 1 quickly, but scaling from 1 to N requires software engineering discipline. Copy-pasting massive AI-generated code blocks (`Ctrl+C` / `Ctrl+V`) without strict code reviews is dangerous and can crash production systems.

---

### Applying to Work & Study

- **Deploy Amazon CloudFront:** Set up CloudFront CDN to serve assets for academic web projects to optimize speed and protect backend APIs.
- **Build Multi-Agent Prototypes:** Use LangChain or CrewAI frameworks to orchestrate coordination between multiple specialized agents for automated workflows.
- **Enforce Code Review Discipline:** Read and comprehend every single line of AI-suggested code before merging. Enforce clean prompt patterns, intelligent temperature limits (`Temperature = 0.1`), and automated testing.

---

### Event Experience

#### Learning from highly skilled speakers
- Absorbed hands-on platform engineering insights from Tín Trương and optimization techniques from Đức Đào.
- Gained insights into infrastructure optimization and edge computing acceleration using Amazon CloudFront from the AWS Infrastructure Expert.

#### Hands-on technical exposure
- Inspired by the LotusHacks team's high-pressure 36-hour sprint to build the UTMorpho MVP, picking up invaluable lessons in teamwork, agility, and scope management.
- Observed live demonstrations of Amazon Quick and the Virtual Credit Committee architecture.

#### Networking & discussions
- Had the opportunity to exchange ideas with students and cloud engineers from various universities and tech firms in HCMC.

#### Lessons learned
- The hyper-accelerated evolution of AI (capabilities doubling every 4 months) demands a proactive, continuous, and non-delayed learning approach.
- The intersection of solid academic engineering fundamentals, disciplined AI utilization, and specialized domain knowledge is the golden key to unlocking premier career opportunities.

---

#### Event Memorabilia Photos
* [Insert your check-in photos, stage views, or exhibitor booth snapshots at Bitexco Financial Tower here]

> **Conclusion:** AWS Community Day Vietnam 2026 was a brilliant learning experience. It not only strengthened my cloud and AI engineering knowledge but also shaped my professional mindset, instilling coding discipline and outlining a clear career development roadmap.
