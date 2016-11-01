module ApplicationHelper
  # def user_signed_in?
  #   session[:user_id].present?
  # end

  def upvote_link(question)
    vote = question.votes.find_by(user: current_user)
     upvote_method = if vote.nil?
                        :post
                      elsif vote.is_up?
                        :delete
                      else
                        :patch
                      end

    upvote_path = if vote.nil?
                    question_votes_path(question, vote: {is_up: true})
                  else
                    vote_path(vote, vote: {is_up: true})
                  end

    link_to fa_icon("arrow-up"), upvote_path, method: upvote_method,
          class: "vote-link #{vote&.is_up? ? 'vote-up' : ''}"
  end

  def downvote_link(question)
    vote = question.votes.find_by(user: current_user)
    downvote_method = if vote.nil?
                        :post
                      elsif vote.is_down?
                        :delete
                      else
                        :patch
                      end
    downvote_path = if vote.nil?
                      question_votes_path(question, vote: {is_up: false})
                    else
                      vote_path(vote, vote: {is_up: false})
                    end

    link_to fa_icon("arrow-down"), downvote_path, method: downvote_method, class: "vote-link #{vote&.is_down? ? 'vote-down' : ''}"

  end

end
