# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: "Frank")
User.create!(user_name: "Sally")
User.create!(user_name: "Bob")

Poll.create!(title: "Presidents", author_id: 1)
Poll.create!(title: "Senators", author_id: 2)

Question.create!(poll_id: 1, text: "Who should be president?")
Question.create!(poll_id: 2, text: "Who should be senator in California?")
Question.create!(poll_id: 2, text: "Who should be senator in New York?")

AnswerChoice.create!(question_id: 1, answer_text: "Donald Trump")
AnswerChoice.create!(question_id: 1, answer_text: "Hillary Clinton")
AnswerChoice.create!(question_id: 2, answer_text: "Jerk McFace")
AnswerChoice.create!(question_id: 2, answer_text: "Cali Fornia")
AnswerChoice.create!(question_id: 3, answer_text: "Bronx NY")
AnswerChoice.create!(question_id: 3, answer_text: "Manhattan NY")
AnswerChoice.create!(question_id: 1, answer_text: "Gary Johnson")

Response.create!(user_id: 1, answer_choice_id: 1)
Response.create!(user_id: 1, answer_choice_id: 3)
Response.create!(user_id: 1, answer_choice_id: 6)
Response.create!(user_id: 2, answer_choice_id: 2)
Response.create!(user_id: 2, answer_choice_id: 4)
Response.create!(user_id: 2, answer_choice_id: 5)
Response.create!(user_id: 3, answer_choice_id: 7)
Response.create!(user_id: 3, answer_choice_id: 5)
