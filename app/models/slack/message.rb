class Slack::Message < ActiveRecord::Base
  self.table_name_prefix = 'slack_'

  validates :content, presence: true

  def links
    URI.extract(content, ["http", "https"]) unless content.nil?
  end

  def from_staff?
    slack_user_name &&
    staff_members &&
    staff_members.include?(slack_user_name)
  end

  def has_link?
    !links.empty?
  end

  def possible_resource?
    from_staff? && has_link?
  end

  def staff_members
    return false unless associated_team_users

    associated_team_users["members"].map { |user|
      user["name"] if user["is_admin"] == true
    }.compact
  end

  def associated_team_users
    slack_api.team_users if slack_api
  end

  def associated_team
    Team.find_by(slack_team_name: slack_team_domain)
  end

  private

  def slack_api
    @_slack_api ||= Slack::Wrapper.new(associated_team.slack_api_token) unless associated_team.nil?
  end
end
