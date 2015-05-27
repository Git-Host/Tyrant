require_relative '../rails_helper'
ActiveRecord::Base.logger = nil


describe Site do
  it "should have a name" do
    s = Site.new( name: 'tyrant' )
    expect(s.name).to eq('tyrant')
  end
  it "should have a domain" do
    s = Site.create( name: 'tyrant' )
    expect(s.subdomain).to eq('tyrant.tyrant.gq')
    s.destroy
  end
  it "should have a subdomain" do
    s = Site.create( name: '&& site -' )
    expect(s.subdomain).to eq('site.tyrant.gq')
    s.destroy
  end
  it "should replace non-word chars" do
    s = Site.create( name: 'WeiJie Gao' )
    expect(s.name).to eq('weijie-gao')
    s.destroy
  end
  it "should not end with a hyphen" do
    s = Site.create( name: 'WeiJie Gao!' )
    expect(s.name).to eq('weijie-gao')
    s.destroy
  end
  it "should not end with a hyphen" do
    s = Site.create( name: 'WeiJie Gao!!!' )
    expect(s.name).to eq('weijie-gao')
    s.destroy
  end
  it "should not start with a hyphen" do
    s = Site.create( name: '!!!WeiJie Gao!!!' )
    expect(s.name).to eq('weijie-gao')
    s.destroy
  end
  it "'s domain shouldnt contain tyrant.gq" do
    s = Site.new( name: "onew" )
    s.domain = "overrideusername.tyrant.gq"
    expect(s.valid?).to eq(false)
  end
  it "'s domain should be a subdomain" do
    s = Site.new( name: "onew" )
    s.domain = "tyrant.gq"
    expect(s.valid?).to eq(false)
  end
  it "'s domain should be a subdomain" do
    s = Site.new( name: "onew" )
    s.domain = "www.tyrant.gq"
    expect(s.valid?).to eq(true)
  end
end