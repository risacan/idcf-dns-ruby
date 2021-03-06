describe Idcf::Dns::ClientExtensions::Zone do
  include_context "resources"

  describe "#create_zone" do
    let(:response) { client.create_zone(attributes) }
    after { ZONES << response.uuid }

    context "when valid request" do
      let(:attributes) { zone_attributes }

      it do
        expect(response.status).to eq 201
        expect(response.success?).to be_truthy
        expect(response.uuid).not_to be nil
      end
    end
  end

  describe "#delete_zone" do
    let(:response) { client.delete_zone(uuid) }

    context "when valid request" do
      let(:uuid) { ZONES.pop }

      it "should succeed" do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
      end
    end
  end

  describe "#get_zone" do
    before { ZONES << client.create_zone(zone_attributes).uuid }
    let(:response) { client.get_zone(uuid) }

    context "when valid request" do
      let(:uuid) { ZONES.last }

      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
        expect(response.body).to be_an_instance_of(Hash)
      end
    end
  end

  describe "#list_zones" do
    let(:response) { client.list_zones }

    context "when valid request" do
      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
        expect(response.body).to be_an_instance_of(Array)
      end
    end
  end

  describe "#update_zone" do
    let(:response) { client.update_zone(uuid, attributes) }

    context "when valid request" do
      let(:uuid) { ZONES.last }
      let(:attributes) { { description: "Updated description." } }

      it do
        expect(response.status).to eq 200
        expect(response.success?).to be_truthy
      end
    end
  end
end
