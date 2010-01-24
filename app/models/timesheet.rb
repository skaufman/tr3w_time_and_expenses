class Timesheet < ActiveRecord::Base
  belongs_to :approver,
             :class_name => 'User',
             :foreign_key => 'approver_id',
             :conditions => ['authorized_approver = ?', true],
             :extend => CheckApproverExtension
  
  belongs_to :user
  
  has_many :billable_weeks, :include => [:billing_code]

  def self.billable_hours_outstanding_for(user)
    user.timesheets.map(&:billable_hours_outstanding).sum
  end

  def billable_hours_outstanding
    submitted? ? billable_weeks.map(&:total_hours).sum : 0
  end
end

class UnauthorizedApproverException < Exception
end
