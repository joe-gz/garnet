class Attendance < ActiveRecord::Base
  belongs_to :event
  belongs_to :membership
  has_one :user, through: :membership

  has_one :cohort, through: :event

  def date
    self.event.date.strftime("%a, %m/%d/%y")
  end

  # TODO: this should use activerecord enums maybe -ab
  def self.statuses
    {
      nil => "n/a",
      0 => "Absent",
      1 => "Tardy",
      2 => "Present"
    }
  end

  def status_english
    return Attendance.statuses[self.status]
  end

  def calculate_status
    now = Time.now
    if now.hour < 9
      2
    elsif now.hour < 13
      1
    else
      0
    end
  end
end
