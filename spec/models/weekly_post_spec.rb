require 'rails_helper'

RSpec.describe WeeklyPost, type: :model do
  describe 'enum' do
    describe 'week' do
      it { is_expected.to define_enum_for(:week).with(Sunday: 0, Monday: 1, Tuesday: 2, Wednesday: 3, Thursday: 4, Friday: 5, Saturday: 6) }
    end
  end

  # describe 'Validation' do
  #   describe 'Inclusion' do
  #     'enum' のテストで確認しているため省略
  #   end
  # end
end
