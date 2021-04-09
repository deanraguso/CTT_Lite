describe Task do
    describe ".to_s" do
        context "given a task" do
            it "serializes to CSV correctly" do
                t = Task.new    
                t.load(
                    0,
                    "Title: X",
                    "Body: X",
                    false,
                    5,
                    5,
                    3,
                    Date.new(2020,01,01),
                    Date.new(2020,01,01),
                    0
                )

                expect(t.to_s).to eq("0,Title: X,Body: X,false,5,5,3,2020-01-01,2020-01-01,0")
            end
        end
    end
end