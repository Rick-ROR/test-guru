class BadgeDistributionService

  RULES = Badge::LIST_RULES

  def initialize(history_test)
    @history_test = history_test
    @user = history_test.user
    @test = history_test.test
  end

  def distribution
      Badge.all.each do |badge|

        if badge.rule == RULES[0]
          dist_level(badge)
        elsif badge.rule == RULES[1]
          dist_category(badge)
        elsif badge.rule == RULES[2]
          dist_first(badge)
        end
      end
  end

  private

  def dist_level(badge)

    if badge.sub_rule !~ /[0-9]/
      return
    else
      level = badge.sub_rule.to_i
    end

    return if @test.level != level || !@user.badges.where(id: badge).empty?

    user_test = @user.tests.where(level: level).pluck(:id).uniq
    all_test = Test.all.where(level: level).pluck(:id)

    if (all_test - user_test).empty?
      UserBadge.create(badge_id: badge.id, test_id: @test.id, user_id: @user.id)
    end
  end

  def dist_category(badge)

    category_title = badge.sub_rule

    return if @test.category.title != category_title || !@user.badges.where(id: badge).empty?

    category = Category.where(title: category_title)
    user_test = @user.tests.where(category: category).pluck(:id).uniq
    all_test = Test.all.where(category: category).pluck(:id)

    if (all_test - user_test).empty?
      UserBadge.create(badge_id: badge.id, test_id: @test.id, user_id: @user.id)
    end
  end


  def dist_first(badge)
    if @user.history_tests.where(test_id: @test).count == 1 && @history_test.passed?
      UserBadge.create(badge_id: badge.id, test_id: @test.id, user_id: @user.id)
    end
  end

end
