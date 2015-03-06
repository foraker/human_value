require "spec_helper"

module HumanValue
  describe Value do
    before do
      HumanValue.enable_extension(:naming)
    end

    describe "a named thing" do
      it "returns the name" do
        named = double(name: "Billows Wendley")
        expect(coerced(named)).to eq "Billows Wendley"
      end

      it "handles missing names" do
        named = double(name: nil)
        expect(coerced(named)).to eq ""
      end
    end
  end
end


