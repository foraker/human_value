require "spec_helper"

module HumanValue
  describe Value do
    describe "#to_s" do
      describe "a string" do
        it "returns the string" do
          expect(coerced("ABC")).to eq "ABC"
        end
      end

      describe "nil" do
        it "returns an empty string" do
          expect(coerced(nil)).to eq ""
        end
      end

      describe "a boolean" do
        it "returns 'Yes' for true" do
          expect(coerced(true)).to eq "Yes"
        end

        it "returns 'No' for false" do
          expect(coerced(false)).to eq "No"
        end
      end

      describe "a number" do
        it "returns a number string" do
          expect(coerced(400)).to eq "400"
        end

        it "adds delimiters" do
          expect(coerced(4000)).to eq "4,000"
        end
      end

      describe "a humanizable value" do
        it "returns 'Yes' for true" do
          humanizable = double(human: "Humanized")
          expect(coerced(humanizable)).to eq "Humanized"
        end
      end

      describe "a value with a model name" do
        it "returns the human model name" do
          humanizable = double(model_name: double(human: "Humanized"))
          expect(coerced(humanizable)).to eq "Humanized"
        end
      end

      describe "a time sort of thing" do
        it "localizes Times" do
          expect(coerced(Time.new(2012, 12, 12))).to eq "12/12/2012"
        end

        it "localizes Dates" do
          expect(coerced(Date.new(2012, 12, 12))).to eq "12/12/2012"
        end
      end
    end
  end
end
