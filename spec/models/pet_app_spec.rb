require 'rails_helper'

RSpec.describe PetApp do
  it { should belong_to(:pet) }
  it { should belong_to(:application) }
end
