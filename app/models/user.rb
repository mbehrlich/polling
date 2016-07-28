class User < ActiveRecord::Base

  validates :user_name, uniqueness: true, presence: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  def completed_polls
    results = Poll.find_by_sql([<<-SQL, self.id])
      SELECT
        p.title
      FROM
        polls p
      JOIN
        questions q ON p.id = q.poll_id
      JOIN
        answer_choices ac ON ac.question_id = q.id
      LEFT JOIN
        responses r ON r.answer_choice_id = ac.id
      WHERE
        r.user_id = ? OR q.id IS NOT NULL
      GROUP BY
        p.id
      HAVING
        COUNT(r.id) = COUNT(q.id)
    SQL
    results
  end

end
