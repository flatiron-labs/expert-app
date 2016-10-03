namespace :adapters do
  desc "TODO"
  task load_all: :environment do
    puts "Starting to load up users..."
    UserAdapter.import
    puts "Users loaded!"
    puts "Starting to load up time sheets..."
    TimeSheetAdapter.import
    puts "Time sheets loaded!"
    puts "Starting to load up Handraise Questions..."
    HandraiseQuestionsAdapter.import
    puts "Handraise questions loaded!"
  end

end
