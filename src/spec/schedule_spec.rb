require_relative 'spec_helper'
require_relative "../Session.rb"
require 'date'

describe Schedule do
    describe ".soft_schedule" do
        context "given a multi-day plan" do
            it "skips rest-days" do
                # Create a test db
                test_db = []
                10.times.each_with_index do |index|
                    t = Task.new
                    t.load(
                        index,
                        "Title: #{index}",
                        "Body: #{index}",
                        false,
                        5,
                        5,
                        3,
                        Date.new,
                        Date.new,
                        0
                    )
                    test_db << t
                end

                # Create a test schedule
                test_schedule = Schedule.new(test_db, 7)

                test_schedule.soft_schedule(test_db, 7)
                weekend_tasks = 0

                # Sum the tasks planned for rest-days
                today = Date.today
                test_schedule.plan.each_with_index do |day, index|
                    # If it's a weekend, and tasks are planned on that day!
                    if test_schedule.rest_days.include?((today + index).cwday%7) &&
                        (day[:tasks].length > 0)
                        weekend_tasks += 1
                    end
                end

                expect(weekend_tasks).to eq(0)
            end
        end
    end
    describe ".hard_schedule" do
        context "given a multi-day plan" do
            it "plans tasks to be completed in the set time." do
                # Create a test db
                test_db = []
                10.times.each_with_index do |index|
                    t = Task.new
                    t.load(
                        index,
                        "Title: #{index}",
                        "Body: #{index}",
                        false,
                        5,
                        5,
                        3,
                        Date.new,
                        Date.new,
                        0
                    )
                    test_db << t
                end

                # Create a test schedule
                test_schedule = Schedule.new(test_db, 3)

                test_schedule.hard_schedule(test_db, 3)

                expect(test_schedule.plan.length).to eq(3)
            end
        end
    end
end