RSpec.describe Handover, type: :model do
  it 'is valid with valid attributes' do
    client = create(:client)
    notebook = create(:notebook)
    handover = build(:handover, client: client, notebook: notebook)

    expect(handover).to be_valid
  end
end
