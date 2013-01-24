namespace :lvrug do
  desc 'make sure there is a kata'
  task :generate_kata => :environment do
    if Kata.open.count == 0
      kata = Kata.generate
      kata.save
    end
  end
end