class Slack::Credentials
  def initialize(user)
    @user = user
  end

  def self.for_oncampus_user(user)
    new(user).for_oncampus_user
  end

  def for_oncampus_user
    team_membership ? basic_credentials : nil
  end

  private

  def team_membership
    @team_membership ||= TeamMembership.
      where(user: @user, team: current_onsite_team).
      where.not(slack_id: nil).first
  end

  def current_onsite_team
    @user.teams.find_by(curriculum: Curriculum.where(category: Curriculum::ON_CAMPUS))
  end

  def api_token_for_oncampus_team
    team_membership.team.slack_api_token
  end

  def basic_credentials
    {
      username: team_membership.slack_username,
      team_api_token: api_token_for_oncampus_team
    }
  end
end
