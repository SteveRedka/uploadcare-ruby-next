RSpec::Matchers.define :be_boolean do
  match do |actual|
    expect(actual).to be(true).or be(false)
  end
end
