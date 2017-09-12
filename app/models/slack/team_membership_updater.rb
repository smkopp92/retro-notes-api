class Slack::TeamMembershipUpdater
  def initialize(team)
    @team = team
  end

  def update_user_memberships!
    api_token ? update_memberships : false
  end

  private
  attr_reader :team

  def api_token
    team.slack_api_token
  end

  def get_users
    slack.team_users["members"]
  end

  def slack
    @slack ||= Slack::Wrapper.new(api_token)
  end

  def slack_email_for(user_from_slack)
    user_from_slack["profile"]["email"]
  end

  def slack_id_for(user_from_slack)
    user_from_slack["id"]
  end

  def slack_username_for(user_from_slack)
    user_from_slack["name"]
  end

  def update_memberships
    return false unless users
    users.each do |slack_user|

      horizon_user = User.find_by(email: slack_email_for(slack_user))
      team_membership = TeamMembership.find_by(team: team, user: horizon_user)

      if team_membership
        team_membership.update_attributes(
          slack_id: slack_id_for(slack_user),
          slack_username: slack_username_for(slack_user)
        )
      end
    end
    true
  end

  def users
    @users ||= api_token ? get_users : nil
  end
end
