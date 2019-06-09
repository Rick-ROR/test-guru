class BadgeDistributionService

  RULES = Badge::LIST_RULES


  def initialize(history_test)
    @history_test = history_test
    @user = history_test.user
    @test = history_test.test
    @badges = []
  end

  def distribution
      Badge.all.each do |badge|
        send badge.rule.downcase.tr(' ', '_'), badge
      end
      @badges
  end

  private

  def all_on_level(badge)

    if badge.sub_rule !~ /[0-9]/
      return
    else
      level = badge.sub_rule.to_i
    end

    return if @test.level != level || !@user.badges.where(id: badge).empty?

    user_test = @user.tests.where(level: level).pluck(:id).uniq
    all_test = Test.all.where(level: level).pluck(:id)

    if (all_test - user_test).empty?
      badge_award(badge)
    end
  end

  def all_in_category(badge)

    category_title = badge.sub_rule

    return if @test.category.title != category_title || !@user.badges.where(id: badge).empty?

    user_test = @user.tests.joins(:category).where(categories: { title: category_title }).pluck(:id).uniq
    all_test = Test.get_by_category(category_title).pluck(:id)

    if (all_test - user_test).empty?
      badge_award(badge)
    end
  end


  def pass_from_the_first_time(badge)
    if @user.history_tests.where(test_id: @test).count == 1 && @history_test.passed?
      badge_award(badge)
    end
  end

  def badge_award(badge)
    UserBadge.create(badge_id: badge.id, test_id: @test.id, user_id: @user.id)
    @badges << badge
  end

end
