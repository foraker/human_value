require "spec_helper"

module HumanValue
  describe Value do
    before do
      HumanValue.enable_extension(:carrierwave)
    end

    describe "an image attachment" do
      it "returns an image tag" do
        attachment = double({
          content_type: "image/jpeg",
          to_s:         "/path/to/file.jpg"
        })
        expect(coerced(attachment)).to eq "<img src='/path/to/file.jpg'>"
      end
    end

    describe "a file attachment" do
      it "returns an link to the file" do
        attachment = double({
          content_type: "application/pdf",
          filename:     "file.pdf",
          to_s:         "/path/to/file.pdf"
        })

        expect(coerced(attachment)).to eq "<a href='/path/to/file.pdf'>file.pdf</a>"
      end
    end
  end
end

