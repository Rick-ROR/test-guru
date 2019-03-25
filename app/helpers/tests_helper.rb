module TestsHelper

  TEST_LEVELS = { 0 => 'легкая', 1 => 'как обычно', 2 => 'надо подумать', 3 => '200 IQ' }.freeze

  def test_level(test)
    TEST_LEVELS[test.level] || :hero
  end

end
