require 'spec_helper'
describe 'globus' do

  context 'with defaults for all parameters' do
    it { should contain_class('globus') }
  end
end
