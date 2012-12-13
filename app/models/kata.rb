class Kata < Topic

  def self.generate
    self.new do |kata|
      kata.title = 'Coding Kata'
      kata.description = <<-KATA
        Coding Katas are short excercises where a person solves a problem infront of others. Here are some resurces:

        Jason's Gem: Shuhari for setting up: https://github.com/jarhart/shuhari
        
        Kata Ideas:
        http://www.rubyquiz.com/
        http://codingdojo.org/

        Tips for a Kata:

        (Judd will add stuff)
      KATA
    end
  end 

  def votes
    total_votes / total_topics
  end

private
  
  def other_topics
    meeting.topics - [ self ]
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