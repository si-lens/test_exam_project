require 'test_helper'

class GiftTest < ActiveSupport::TestCase
  test 'finding gifts for given interest' do
    assert Gift.for_interest('biology').any?
    assert_equal 2, Gift.for_interest('chemistry').count
    assert_empty Gift.for_interest('math')
  end

  test 'data driven testing in Ruby' do
    data_driven_test_file = JSON.parse(File.read('test/models/gifts_ddt.json'))
    Gift.create!(data_driven_test_file["gifts"])
    
    data_driven_test_file["units"].each do |unit|
      assert_equal Gift.for_interest(unit["interest"]).pluck(:name), unit["expected_gifts"]
    end
  end
end
