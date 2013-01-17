class Kata < Topic

  def self.generate
    self.new do |kata|
      kata.title = 'Coding Kata'
      kata.description = <<-KATA
Coding Katas are short excercises where a person solves a problem infront of others while using test driven development. 

Here are some resurces:

Jason's ruby gem is called Shuhari and is great for helping you get set up: https://github.com/jarhart/shuhari

Kata Ideas:

You can do a kata on just about anyting. It's best to keep it simple and incororate best pratices like refactoring and testing.
http://www.rubyquiz.com/
http://codingdojo.org/

Tips for a Kata:

(Judd will add stuff)
      KATA
    end
  end 

  def give_points_to(presenter)
    [
      { name: user_name, points: 0 },
      { name: presenter.name, points: presenter.earn_points!(presenter_points)}
    ]
  end

  def votes
    if total_topics == 0
      0
    else
      total_votes / total_topics
    end
  end

private

  def suggestion_points
    0
  end
  
  def meeting_topics
    p meeting_id
    if meeting_id 
      meeting.topics
    else
      []
    end
  end

  def other_topics
    meeting_topics - [ self ]
  end

  def current_vote_counts
    other_topics.map(&:votes)
  end

  def previous_vote_counts
    Meeting.closed.flat_map(&:topics).map(&:votes)
  end

  def previous_vote_total
    previous_vote_counts.inject(0, :+)
  end

  def current_vote_total
    current_vote_counts.inject(0, :+)
  end

  def total_topics
    previous_vote_counts.count + current_vote_counts.count
  end

  def total_votes
    current_vote_total + previous_vote_total
  end
end