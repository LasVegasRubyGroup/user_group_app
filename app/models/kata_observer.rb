class KataObserver < Mongoid::Observer

  # def after_save(_)
  #   if Kata.open.count == 0
  #     kata = Kata.generate
  #     kata.save
  #   end
  # end

end