---
title: "Demo Video"
date: 2026-06-28
weight: 8
chapter: false
pre: " <b> 8. </b> "
---

# 📋 System Functionality List

The document summarizes the main functions of users (User) and administrators (Admin) on the AWS Serverless Event Management Portal system.

<iframe src="https://drive.google.com/file/d/1Y3MPZf0hw9Wffg0gG8jd0tQ1gRZOB3bQ/preview" width="100%" height="450" allow="autoplay"></iframe>

## 👥 1. User Functions (User / Visitor)

*   **View & search events:** Browse the list of existing events, search by keywords, or quickly filter by category (Technology, Music, Sports...).
*   **View event details:** View description, location, time, remaining seats, previous reviews, and related suggested events.
*   **Register & Login:** Create a new account or log in to the secure system via Cognito.
*   **Register & book tickets:** Book tickets for events with remaining seats, receive electronic tickets and QR codes for attendance check-in.
*   **Join waitlist:** Enter registration details in the queue when the event is fully booked.
*   **Manage personal profile:** View the history of booked events, change passwords, and opt to delete the account.
*   **Review events:** Rate with stars and submit feedback for events actually attended (checked-in).
*   **Export personal calendar:** Download `.ics` calendar files or add events directly to Google Calendar.

---

## 👑 2. Admin Functions (Admin)

*   **Event management (CRUD):** Add new events, update details, or delete events from the system.
*   **Manage participant list:** View the detailed list of registered participants for each event (Email, Ticket ID, Booking Date, Ticket Status).
*   **QR Code Attendance (Check-in):** Scan the QR code on the guest's ticket (or enter the ticket ID manually) to confirm attendance and prevent duplicate ticket use.
*   **Access control:** Manage a separate Dashboard interface for Admins and automatically prevent access from regular accounts.
