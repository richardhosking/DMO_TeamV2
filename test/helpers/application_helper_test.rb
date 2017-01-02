require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "DMO Team Management Software"
    assert_equal full_title("Help"), "Help | DMO Team Management Software"
  end
end