require "rails_helper"

RSpec.describe Food, type: :model do
  describe "Food Model" do
    context "invalid attributes" do
      before do
        @params = {
          name: "Meatballs",
          description: "A round shaped meat",
          price: 100000
        }
      end

      it "should fail when name is empty" do
        expect(Food.new(@params.slice(:description, :price))).to_not be_valid
      end

      it "should fail when description is empty" do
        expect(Food.new(@params.slice(:name, :price))).to_not be_valid
      end

      it "should fail when price is empty" do
        expect(Food.new(@params.slice(:name, :description))).to_not be_valid
      end

      it "should fail when the price is not float" do
        expect(Food.create({ name: "Meatballs", description: "A round shaped meat", price: "asd" })).to_not be_valid
      end

      it "should fail when the description length is more than 100" do
        expect(Food.create({
          name: "Meatballs",
          description: "scoSQYjFebApttSjenovV5R8PN3OcTt14GvTZQX9JIDUe62cQsmpuqvymqgfaxvZQGeZI7d9Wes7EbSmFkYPFs4hm0ZowcpgxhYwP5A2oJmHYN",
          price: 100
          })
        ).to_not be_valid
      end
    end
  end
end
