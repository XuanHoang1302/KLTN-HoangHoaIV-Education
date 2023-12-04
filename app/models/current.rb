# frozen_string_literal: true

# A word of caution:
# The `Current` singleton can be really powerful, but it can also do much harm
# when it's used incorrectly. If you need to add something, please ask yourself:
# is there really no other way to achieve this?
#
# Read more about the CurrentAttributes here:
# https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html
#
# Or checkout this Youtube video by DHH on using global:
# https://www.youtube.com/watch?v=D7zUOtlpUPw
class Current < ActiveSupport::CurrentAttributes
  attribute :user, :context

  class Context
    def self.create(context)
      ActiveSupport::StringInquirer.new(context.to_s)
    end
  end
end