class User < ActiveRecord::Base
  has_many(
    :enrollments,
    class_name: 'Enrollment',
    foreign_key: :student_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :user_id,
    primary_key: :id
  )


end
