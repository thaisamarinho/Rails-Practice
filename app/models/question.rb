class Question < ApplicationRecord

  belongs_to :user

  # this sets up the one to many association from the question model. you always provide plural from the model, in this case 'answers'
  # this will give us handy methods to easily work with the association
  # thi must provude a 'dependent' option to your has_many
  # you can put :destroy if you'd like to delete all the answers associated with a question when the question gets deleted.
  # you can also put ':nullify' which will update all the asssociated answers to have a question_id of null when the question is deleted
  has_many :answers, lambda { order(created_at: :desc)}, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: {case_sensitive: false, message: "Must be unique"}
  # with scope we validate that the combination of two fields is unique. In the
  # example below, we're validating that the combination of title/body is unique
  validates :body, length: { minimum: 5 },
                uniqueness: { scope: :title }

  validates(:view_count, { numericality: { greater_than_or_equal_to: 0 } })

  validate :no_monkey

  after_initialize :set_defaults
  before_validation :titleize_title


  def user_full_name
    if user
      user.full_name
    else
      'Annonimous'
    end
  end

  def like_for(user)
    likes.find_by(user: user)
  end

   # scope :recent_ten, lambda { limit(10).order(created_at: :desc) }

   def vote_value
     votes.up.count - votes.down.count
   end

  private

  def no_monkey
    if title && title.include?('monkey')
      errors.add(:title, 'No monkeys please!')
    end
  end

  def set_defaults
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize
  end


end
