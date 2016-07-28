class Response < ActiveRecord::Base

  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :no_author_response

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def super_siblings
    result = Response.find_by_sql([<<-SQL, self.id, self.id])
      SELECT
        r.*
      FROM
        responses r
      JOIN
        answer_choices ac ON r.answer_choice_id = ac.id
      JOIN
        questions q ON q.id = ac.question_id
      WHERE
        NOT (r.id = ?) AND q.id IN (
          SELECT
            q.id
          FROM
            questions q
          JOIN
            answer_choices ac ON ac.question_id = q.id
          JOIN
            responses r ON r.answer_choice_id = ac.id
          WHERE
            r.id = ?
          )
    SQL
    result

  end

  def not_duplicate_response
    if respondent_already_answered?
      self.errors[:response] <<
        "you have already answered this question."
    end
  end

  def no_author_response
    if question.poll.author_id == respondent.id
      self.errors[:response] << "author cannot respond to their own poll!"
    end
  end

end
