class Slack::ApiFake
  # DEFAULT_FAIL = {"ok"=>false, "error"=>"not_authed"}
  # @@fail = false
  # @@messages = []
  # cattr_accessor :messages
  #
  # def self.chat_post_message(data)
  #   @@messages << data
  #   if @@fail
  #     DEFAULT_FAIL
  #   else
  #     {
  #       "ok" => true,
  #       "channel" => "",
  #       "ts" =>"",
  #       "message" =>{
  #         "text" => data[:query][:text],
  #         "type" => "message",
  #       }
  #     }
  #   end
  # end
  #
  # def self.team_info(data)
  #   if @@fail
  #     DEFAULT_FAIL
  #   else
  #     {
  #       "ok" => true,
  #       "team" => {
  #         "id" => "T12345",
  #         "name" => "My Team",
  #         "domain" => "example",
  #         "email_domain" => "",
  #         "icon" => {
  #           "image_34" => "https:\/\/...",
  #           "image_44" => "https:\/\/...",
  #           "image_68" => "https:\/\/...",
  #           "image_88" => "https:\/\/...",
  #           "image_102" => "https:\/\/...",
  #           "image_132" => "https:\/\/...",
  #           "image_default" => true
  #         }
  #       }
  #     }
  #   end
  # end
  #
  # def self.team_users(team)
  #   if @@fail
  #     DEFAULT_FAIL
  #   else
  #     {
  #       "ok" => true,
  #       "members" =>[
  #         {
  #           "id" => "SLACK_ID",
  #           "name" => "SLACK_USERNAME",
  #           "profile" => {
  #             "first_name" => "SLACK_FIRST_NAME",
  #             "last_name" => "SLACK_LAST_NAME",
  #             "email" => "firstname.lastname@email.com"
  #           },
  #           "is_admin" => false,
  #           "is_owner" => false
  #         },
  #         {
  #           "id" => "SLACK_ADMIN_ID",
  #           "name" => "SLACK_ADMIN_USERNAME",
  #           "profile" => {
  #             "first_name" => "SLACK_ADMIN_FIRST_NAME",
  #             "last_name" => "SLACK_ADMIN_LAST_NAME",
  #             "email" => "firstname.lastname@launchacademy.com"
  #           },
  #           "is_admin" => true,
  #           "is_owner" => false
  #         }
  #       ]
  #     }
  #   end
  # end
  #
  # def self.channels_list(data)
  #   if @@fail
  #     DEFAULT_FAIL
  #   else
  #     {
  #       "ok" => true,
  #       "channels" => [
  #         {
  #           "id" => "C024BE91L",
  #           "name" => "fun",
  #           "created" => 1360782804,
  #           "creator" => "U024BE7LH",
  #           "is_archived" => false,
  #           "is_member" => false,
  #           "num_members" => 6,
  #           "topic" => {
  #             "value" => "Fun times",
  #             "creator" => "U024BE7LV",
  #             "last_set" => 1369677212
  #           },
  #           "purpose" => {
  #             "value" => "This channel is for fun",
  #             "creator" => "U024BE7LH",
  #             "last_set" => 1360782804
  #           }
  #         }
  #       ]
  #     }
  #   end
  # end
  #
  # def self.user_admin_invite(data)
  #   if @@fail
  #     DEFAULT_FAIL
  #   else
  #     @@messages << data
  #     { "ok" => true }
  #   end
  # end
  #
  # def self.fail!
  #   @@fail = true
  # end
  #
  # def self.reset!
  #   @@fail = false
  #   @@messages = []
  # end
end
