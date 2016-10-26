class Answer < ApplicationRecord
  # Having this belongs_to method here enables us to have features for the Answer model that makes it easy to user in association with the question model. the model you reference with 'belongs_to' should be provided as singular
  belongs_to :question

  belongs_to :user
  
  validates :body, presence: true
end
