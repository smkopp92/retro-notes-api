class Slack::Inviter
  def initialize(team)
    @team = team
  end

  def invite_all!
    if team_has_slack_info?
      invite_team_to_slack
    else
      record_missing_slack_error
    end
    !errors.any?
  end

  def invite(user)
    if team_has_slack_info? && uninvited_users.include?(user)
      send_invitation(user)
    end
  end

  def errors
    @_errors ||= []
  end

  private

  attr_accessor :team

  def invite_team_to_slack
    uninvited_users.each do |user|
      send_invitation(user)
    end
  end

  def send_invitation(user)
    response = slack.invite(user.email)
    if response["ok"]
      update_slack_info_for(user)
    else
      record_error(user, response)
    end
  end

  def record_missing_slack_error
    errors << "The slack team is missing the Slack Api token. Have an admin register an API token at https://api.slack.com/web"
  end

  def record_error(user, response)
    message = "#{user.display_name} (#{user.email} failed with an error: #{response["error"]} )"
    errors << message
  end

  def update_slack_info_for(user)
    membership = user.team_memberships.find_by(team: team)
    membership.update_attributes(invited_to_slack: DateTime.now)
  end

  def slack
    Slack::Wrapper.new(api_token)
  end

  def team_has_slack_info?
    api_token.present?
  end

  def api_token
    team.slack_api_token
  end

  def uninvited_users
    ids = []
    if team.online_intensive?
      ids = memberships.where(invited_to_slack: nil).where.not(phase: nil).pluck(:user_id)
    else
      ids = memberships.where(invited_to_slack: nil).pluck(:user_id)
    end
    users.where(id: ids)
  end

  def memberships
    team.team_memberships
  end

  def users
    team.users
  end
end
