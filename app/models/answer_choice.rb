class AnswerChoice < ActiveRecord::Base

  validates :answer_text, :question_id, presence: true

  belongs_to :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :Question

  has_many :responses, dependent: :destroy,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :Response

end
