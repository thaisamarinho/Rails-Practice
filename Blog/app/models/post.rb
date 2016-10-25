

class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 7 }
  validates :body, presence: true
  belongs_to :category
  belongs_to :user

  has_many :comments, lambda {order(created_at: :desc)}, dependent: :destroy


  def body_snippet
    if self.body.length > 100
      return self.body[0...100] + "..."
    else
      return self.body
    end
  end

end
