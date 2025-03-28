# 1. Introduction

### Project Overview

An educational platform designed for teachers and students. It provides a comprehensive solution that enables teachers to deliver lessons and interactive sessions without heavy technical overhead, while students gain access to quality instruction from beyond their local area—all with integrated payment, AI enhancements, and gamification features.

### Target Audience

- **Teachers:**
    - Need a private, easy-to-use platform to share content and protect their rights.
- **Students:**
    - Want access to quality education from skilled teachers outside their local area, with cost and effort savings.

---

# 2. Functional Requirements

## General:

### User Management

- **Authentication & Registration:**
    - The system shall allow users to sign up and log in.
    - The system shall support role-based access control (Teacher, Student, Admin).

### Course and Video Content Management

- **Video Player:**
    - The system shall integrate an external video player to display course videos.
        - Based on Youtube Video Embedding
    - The system shall overlay a watermark containing the user's UUID to prevent unauthorized distribution.
- **Course Content:**
    - The system shall allow teachers to attach notes for each video within a course.

### Tracking

- Track student progress in courses.

### Search and Filtering

- **Search Functionality:**
    - The system shall provide a search feature that allows users to search courses and teachers using multiple filters (e.g., subject, rating, price).
    - The system shall support sorting search results by various criteria (e.g., rating, popularity).

### Ratings and Reviews

- **Review Submission:**
    - The system shall allow students to rate and review courses.
    - If a review rate falls below a specific limit (e.g., 2-stars), the system shall require the user to provide a reason.
- **Teacher Rating Calculation:**
    - The system shall compute teacher ratings based on aggregated course ratings.
    - The teacher reviews are the collection of all course reviews

### Payment and Service Purchase

- **Content based subscription for each course:**

### Chat and Communication

- **Messaging Module:**
    - The system shall provide an email-like chat system for communication.
- **Discussion:**
    - Can discuss lessons in the course with other students.

### Gamification: Points System

- **Points Accumulation and Use:**
    - The system shall allocate points for different activities (e.g., quizzes yield more points than watching videos).
    - Leaderboard for each course

### AI Features

- **Question Generation:**
    - The system shall leverage AI to generate questions based on course material.
    - Teacher can provide pdf which questions can be extracted from

---

# 3. Non-Functional Requirements

### Performance

- **Response Time:**
    - The system shall load critical pages within 2–3 seconds under normal network conditions.
- **Scalability:**
    - The application shall be designed to scale as the user base and content grow.

### Security

- **Data Protection:**
    - The system shall enforce secure authentication with encrypted password storage.
    - Protect content from being used or shared without access
- **Compliance:**
    - The system shall include a comprehensive EULA (الشروط و الأحكام) and respect content copyright.

### Usability

- **User Interface:**
    - The platform shall be user-friendly and accessible for both teachers and students.
- **Error Handling:**
    - The system shall provide clear error messages and guidance for recovery.

### Maintainability

- **Modular Architecture:**
    - The system shall adopt a modular design to facilitate easy updates and integration of new features.
- **Documentation:**
    - The platform shall include detailed documentation for both end-users and developers.

### Integration

- **Third-Party Services:**
    - The system shall integrate with external video hosting platforms, payment gateways, and meeting services (e.g., for generating meeting links).

---

# 4. Constraints

- **Video Streaming:**
    - The system shall not include built-in video hosting or streaming but must integrate with an external solution.
- **Content Copyright:**
    - The system shall include measures (like watermarks) to protect video content.
- **Legal Compliance:**
    - The system shall enforce an EULA and comply with local laws regarding content and payments.

---

# 5. User Stories and Acceptance Criteria

### User Story 1: Teacher Registration and Course Management

- **Story:**
"As a teacher, I want to sign up, manage my profile, and create courses so that I can share my content easily without technical overhead."
- **Acceptance Criteria:**
    - A teacher can register with a secure sign-up process.
    - A teacher can create, edit, and delete courses.
    - The system assigns a unique role (Teacher) and provides access to course management functionalities.

### User Story 2: Student Course Enrollment and Search

- **Story:**
"As a student, I want to search for courses using multiple filters and enroll in courses to learn from top-rated teachers."
- **Acceptance Criteria:**
    - The search functionality allows filtering by subject, rating, and price.
    - Students can enroll in a course after selecting it from search results.

### User Story 3: Video Playback with Watermark

- **Story:**
"As a user, I want to view course videos that display a watermark with my UUID to protect content rights."
- **Acceptance Criteria:**
    - When a video is played, the watermark (user UUID) is visible.
    - The watermark is applied consistently across all video sessions.

### User Story 4: Payment and Service Purchase

- **Story:**
"As a student, I want to purchase specific lessons or quizzes using local payment methods so that I can access course content."
- **Acceptance Criteria:**
    - The payment gateway supports local methods.
    - The system processes transactions and unlocks purchased content upon successful payment.

### User Story 5: AI-Driven Enhancements

- **Story:**
"As a user, I want to ask questions about course content, and get AI-generated questions to enhance my learning experience."
- **Acceptance Criteria:**
    - Users can enter queries and receive AI-based responses.
    - AI-generated questions are provided and, if applicable, integrated into assessments.

---

# 6. Final Deliverables

According to the project guidelines, the final submission should include:

1. **SRS Document:**
    - Detailed requirements (both functional and non-functional), use cases, and user stories.
2. **System Design Document:**
    - Architectural design, database schema (with ER diagrams), and UML diagrams.
3. **Implementation Code:**
    - Well-documented and version-controlled code.
4. **Test Plan and Test Cases:**
    - Unit and integration tests with acceptance criteria.
5. **Deployment Documentation:**
    - Hosting platform details, CI/CD setup, and backup/recovery plans.
6. **User Manual:**
    - Basic guide on how to use the system.