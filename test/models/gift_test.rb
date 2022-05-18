require 'test_helper'

class GiftTest < ActiveSupport::TestCase
  setup do
    gifts_json = File.read('db/seed_data/gifts.json')
    gifts_hash = JSON.parse(gifts_json)
    Gift.create!(gifts_hash)
  end
  test 'finding gifts for given interest' do
    assert Gift.for_interest('biology').any?
    assert_equal 2, Gift.for_interest('chemistry').count
    assert_empty Gift.for_interest('math')
  end

  test 'Gift should be found based on interest' do
    [
      { interest: 'music', expected_gifts: ['second hand earplugs', 'netflix card', 'spotify voucher'] },
      { interest: 'film', expected_gifts: ['netflix card'] },
      { interest: 'pets', expected_gifts: ['dog treats', 'dog halloween costume', 'netflix card'] },
      { interest: 'scifi', expected_gifts: ['netflix card'] },
      { interest: 'power lifting', expected_gifts: ['gold plated water bottle'] },
      { interest: 'triathlons', expected_gifts: ['running shoes', 'gold plated water bottle'] },
      { interest: 'football', expected_gifts: ['gold plated water bottle', 'peterborough united football shirt'] },
      { interest: 'crossfit', expected_gifts: ['gold plated water bottle'] },
      { interest: 'handball', expected_gifts: ['gold plated water bottle'] },
      { interest: 'running', expected_gifts: ['running shoes', 'gold plated water bottle'] },
      { interest: 'techno', expected_gifts: ['second hand earplugs'] },
      { interest: 'drinking', expected_gifts: ['6 pack of beer', 'bottle of wine', 'cocktail mixer'] },
      { interest: 'football', expected_gifts: ['gold plated water bottle', 'peterborough united football shirt'] },
      { interest: 'botany', expected_gifts: ['bonsai tree'] },
      { interest: 'scuba', expected_gifts: ['goggles'] },
      { interest: 'eating', expected_gifts: ['recipe book'] },
      { interest: 'family', expected_gifts: ['family vacation to disneyland'] },
      { interest: 'german', expected_gifts: ['book of german phrases'] },
      { interest: 'reading', expected_gifts: ['book of german phrases'] },
      { interest: 'cocktails', expected_gifts: ['cocktail mixer'] },
      { interest: 'yoga', expected_gifts: ['yoga ball'] },
      { interest: 'sitting comfortably', expected_gifts: ['yoga ball'] },
      { interest: 'photography', expected_gifts: ['book on photographing nature'] }
    ].each do |unit|
      assert_equal Gift.for_interest(unit[:interest]).pluck(:name), unit[:expected_gifts]
    end
  end
end
