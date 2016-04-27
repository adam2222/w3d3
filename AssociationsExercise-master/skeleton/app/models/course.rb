class Course < ActiveRecord::Base
  has_many(
    :enrollments,
    class_name: 'Enrollment',
    foreign_key: :course_id,
    primary_key: :id
  )

  belongs_to(
    :prerequisite,
    class_name: 'Course',
    foreign_key: :prereq_id,
    primary_key: :id
  )

  has_many(
    :students,
    through: :enrollments,
    source: :student
  )

  belongs_to(
    :instructor,
    class_name: 'User',
    foreign_key: :instructor_id,
    primary_key: :id
  )

end


c = Course.first

Course.find(c.prereq_id)

c.prerequisite


c.prequisite




SELECT
  students.*
FROM
  courses
WHERE
  course.id = ? (self.prereq_id)




SELECT
  students.*
FROM
  students
JOIN
  enrollements ON student.id = enrollments.student_id
WHERE
  enrollment.course_id = ? (self.id)
