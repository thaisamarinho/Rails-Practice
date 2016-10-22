require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do

    it 'require title' do
      p = Project.new due_date: DateTime.now + 1.day
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it 'require unique title' do
      Project.create(title: "Hello", due_date: DateTime.now + 1.day)
      p = Project.new({title: "Hello", due_date: DateTime.now + 1.day})
      p.valid?
      expect(p.errors).to have_key(:title)
    end
    it 'require update' do
      p = Project.create({title: "Hello", due_date: '2016-02-08'})
      p.valid?
      expect(p.errors).to have_key(:due_date)
    end
  end
end
