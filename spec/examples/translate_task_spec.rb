require File.dirname(__FILE__) + '/spec_helper'
require 'yaml'

describe 'translate' do

  it 'should be able to convert a basic array' do
    locale = LocaleBase::Translator.new ['one', 'two', 'three']
    locale.translate(:to => :spanish).should == ['uno', 'dos', 'tres']
  end

  it 'should be able to convert a yaml file' do
    locale = LocaleBase::Translator.new YAML.load_file('spec/examples/sample/locale_basic.yml')
    lambda do
      locale.translate(:to => :spanish)
    end.should_not raise_error
  end

  it 'should be able to convert a hash with an array inside of it, and skip the keys' do
    locale = LocaleBase::Translator.new 'numbers' => ['one', 'two', 'three']
    locale.translate(:to => :es).should == { 'numbers' => ['uno', 'dos', 'tres'] }
  end

  it 'should be able to convert a single string' do
    locale = LocaleBase::Translator.new 'uno'
    locale.translate(:from => :es, :to => :en).should == 'one'
  end

  it 'should be able to have a complicated hash set' do
    locale = LocaleBase::Translator.new 'numbers' => { 'singles' => ['one', 'two'], 'teens' => ['ten', 'fifteen'] }
    locale.translate(:from => :en, :to => :es).should == { 'numbers' => { 'singles' => ['uno', 'dos'], 'teens' => ['diez', 'quince'] } }
  end

  it 'should be able to work with {{variables}} without modifying them' do
    locale = LocaleBase::Translator.new 'one {{variable}} two'
    locale.translate(:from => :en, :to => :es).should == 'uno {{variable}} dos'
  end

  it 'should be able to deal with multiple variables without confusing them' do
    locale = LocaleBase::Translator.new 'one {{var1}} two {{var2}} three'
    locale.translate(:from => :en, :to => :es).should == 'uno {{var1}} dos {{var2}} tres'
  end

  it 'should be able to deal with multiple variables with non-alphanum chars' do
    locale = LocaleBase::Translator.new 'one {{:var_1}} two {{:var_2}} three'
    locale.translate(:from => :en, :to => :es).should == 'uno {{:var_1}} dos {{:var_2}} tres'
  end

  it 'should be able to have two of the same variable in a string' do
    locale = LocaleBase::Translator.new 'one {{variable}} one {{variable}} two'
    locale.translate(:from => :en, :to => :es).should == 'uno {{variable}} uno {{variable}} dos'
  end

  it 'should be able to have two variables separated by a space' do
    locale = LocaleBase::Translator.new 'one {{variable1}} {{variable2}} two'
    locale.translate(:from => :en, :to => :es).should == 'uno {{variable1}} {{variable2}} dos'
  end

  # waiting on google for this one
  it 'should be able to have two variables right next to each other'
  #  locale = Translator.new 'one {{variable1}}{{variable2}} two'
  #  locale.translate(:from => :en, :to => :es).should == 'uno {{variable1}}{{variable2}} dos'
  #end

  it 'should be able to operate on extremely large objects, by chunking' do
    obj = []
    10.times { obj << "Now is the time for all good men to come to the aid of their country" }
    locale = LocaleBase::Translator.new obj
    translation = locale.translate(:from => :en, :to => :en)
    translation.size.should == 10
    translation.each { |t| t.should == 'Now is the time for all good men to come to the aid of their country' }
  end

  it 'should be able to translate something with a crazy evaluation inside of a variable spot' do
    locale = LocaleBase::Translator.new 'and this is {{puts 2*x + y}} math'
    translation = locale.translate(:from => :en, :to => :es)
    translation.should == 'y esto es {{puts 2*x + y}} matemáticas'
  end

end
