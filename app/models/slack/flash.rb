class Slack::Flash
  def initialize(user, view_context)
    @user = user
    @team_membership = user.team_memberships.last
    @view_context = view_context
  end

  def message
    info = "You have not configured Slack yet. "
    info << "#{@view_context.link_to 'Send Invite.', @view_context.team_membership_slack_invites_path(@team_membership), method: :post}"
  end

  def message_needed?
    user_in_online_or_ignition? &&
    !user_has_slack_id? &&
    !user_is_in_remote_slack_team? &&
    user_has_started_curriculum_or_in_ignition? &&
    user_not_in_phase_0
  end

  private

  def user_in_online_or_ignition?
    team = @team_membership.team if @team_membership.present?
    (team.online_intensive? || team.ignition?) if team.present?
  end

  def user_has_slack_id?
    @team_membership.slack_id?
  end

  def user_is_in_remote_slack_team?
    if @team_membership.team.slack_api_token.present?
      slack = Slack::Wrapper.new(@team_membership.team.slack_api_token)
      team_emails = slack.team_users['members'].map { |member| member['profile']['email'] }
      team_emails.include? @user.email
    end
  end

  def user_has_started_curriculum_or_in_ignition?
    team = @team_membership.team if @team_membership.present?
    (team.online_intensive? && @team_membership.phase.present?) || team.ignition?
  end

  def user_not_in_phase_0
    ![0,"0",nil].include? @team_membership.phase
  end
end
