class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true

  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many :visitors, through: :visits, source: :user



  def self.random_code
    code = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(['short_url = ?', code])
      code = SecureRandom.urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create(
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      user_id: user.id
    )
  end

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors.map { |m| m.id }
  end

  def num_recent_uniques

  end

end



a = User.new(email: 'blah@blah.com')
a.save

s = ShortenedUrl.new
s.long_url = 'string'
s.short_url = 'short'
s.user = a
s.save




# class User < ActiveRecord::Base
#   has_many(
#     :enrollments,
#     class_name: 'Enrollment',
#     foreign_key: :student_id,
#     primary_key: :id
#   )
#
#   has_many :courses, through: :enrollments, source: :course
#
# end
#
# class Course < ActiveRecord::Base
#   has_many(
#     :enrollments,
#     class_name: 'Enrollment',
#     foreign_key: :course_id,
#     primary_key: :id
#   )
#
#   belongs_to(
#     :prerequisite,
#     class_name: 'Course',
#     foreign_key: :prereq_id,
#     primary_key: :id
#   )
#
#   has_many(
#     :students,
#     through: :enrollments,
#     source: :student
#   )
#
#   belongs_to(
#     :instructor,
#     class_name: 'User',
#     foreign_key: :instructor_id,
#     primary_key: :id
#   )
#
# end
