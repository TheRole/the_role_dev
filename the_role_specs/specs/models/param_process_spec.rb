# encoding: UTF-8
# /home/the_role_dev/rails6-app# bundle exec rspec ../the_role_specs/specs/models/param_process_spec.rb

require 'rails_helper'

describe "String to slug" do
  it 'string process 1' do
    expect('hello world!'.to_slug_param(sep: '_')).to eq 'hello_world'
  end

  it 'string process 2' do
    expect(:hello_world!.to_slug_param(sep: '_')).to eq 'hello_world'
  end

  it 'string process 3' do
    expect("hello !      world".to_slug_param(sep: '_')).to eq 'hello_world'
  end

  it 'string process 4' do
    expect("HELLO  $!= WorlD".to_slug_param(sep: '_')).to eq 'hello_world'
  end

  it 'string process 5' do
    expect("HELLO---WorlD".to_slug_param(sep: '_')).to eq 'hello_world'
  end

  it "should work with Controller Name" do
    class PagesController < ApplicationController; end
    ctrl = PagesController.new
    ctrl.controller_path
    expect(ctrl.controller_path.to_slug_param(sep: '_')).to eq 'pages'
  end

  it "should work with Nested Controller Name" do
    class Admin; end
    class Admin::PagesController < ApplicationController; end
    ctrl = Admin::PagesController.new
    ctrl.controller_path

    expect(ctrl.controller_path.to_slug_param(sep: '_')).to eq 'admin_pages'
  end
end
