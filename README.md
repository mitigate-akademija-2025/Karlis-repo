# README
August 2025
Quiz app project made with Ruby on Rails. 

- ruby 3.4.1
- Rails 8.0.2
- sqlite3 3.45.3

- cocoon (1.2.15)
- devise (4.9.4)
- pundit (2.5.0)


See `Gemfile.lock` for full dependency details

Pics from project - https://failiem.lv/u/e2s7apr6p5

Project uses Devise for user authentication, allowing users to register, sign in and manage their accounts securely. Authorization is enforced by pundit so only quiz authors or admins can edit and delete quizzes.
App uses Cocoon gem for dynamic nested forms, enabling users to add multiple questions and answers to quizzes during creating and also to mark correct answers. Tailwind CSS for UX/UI.

Other features:

- custom point values for each question
- quiz scoring
- user reviews after completing quiz
- search quiz by name
- my profile page (shows quizzes made by user and last 5 quizzes completed)

