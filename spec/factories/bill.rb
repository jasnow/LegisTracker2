FactoryGirl.define do
  factory :bill do
    btype 'HB'
    num '1'
    number 'HB1'
    short_title 'A Makebelieve Bill'
    title 'A BILL to be entitled A Make Beleive Bill ' +
      'which does absolutely nothing'
    b_status 'House Passed/Adopted'
    status_code_id 'HFCR'
    crossover 0
  end
end
