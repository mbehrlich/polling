class Question < ActiveRecord::Base

  validates :poll_id, :text, presence: true

  has_many :answer_choices, dependent: :destroy,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def n_plus_one_results
    hash = Hash.new(0)
    answer_choices.each do |answer|
      hash[answer.answer_text] = answer.responses.count
    end
    hash
  end

  def results
    hash = Hash.new(0)
    answers = answer_choices.includes(:responses)
    answers.each do |answer|
      hash[answer.answer_text] = answer.responses.length
    end
    hash
  end

  def better_results
    results = AnswerChoice.find_by_sql([<<-SQL, self.id])

      SELECT
        ac.answer_text, COUNT(r.id) as votes
      FROM
        answer_choices AS ac
      LEFT JOIN
        responses AS r ON ac.id = r.answer_choice_id
      WHERE
        ac.question_id = ?
      GROUP BY
        ac.id
    SQL
    results_hash = {}
    results.each do |result|
      results_hash[result.answer_text] = result.votes
    end
    results_hash
  end
end
