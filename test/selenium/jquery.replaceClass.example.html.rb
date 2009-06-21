#!/usr/bin/env ruby
# :title:Selenium Helper
# = Name
# Selenium Helper
# = Description
# Provide setup, teardown and other utility methods for using Selenium with Test::Unit.
# === Dependencies
#
#     sudo gem install Selenium selenium-client
#
# Requires Selenium Server Beta 1+ running on port 4444.

require "rubygems"
require "test/unit"
#gem "selenium-client", ">=1.2.9"
require "selenium/client"

# == Todo Assertion for Test::Unit
# Provide a todo assertion for Test::Unit.
# Behaves like Perl's Test::More TODO assertion.
# See <http://perldoc.perl.org/Test/Tutorial.html>

module TodoAssertion

  def todo message
    assert_block "UNEXPECTEDLY SUCCEEDED: #{message}" do
      begin
        yield
      rescue 
        puts "\nTODO: #{message}"
        puts "      " + $@.first
        puts "#     " + $!
        return true
      end
    end
  end

end


module SeleniumCommandShortcuts

  # == Stringified JavaScript reference to the window object of the Application Under Test.
  $window = 'this.browserbot.getCurrentWindow().'

  # == Prepend some stringified JavaScript with a reference to the window object of the Application Under Test.
  def js_get(js_string)
    return @selenium.js_eval($window + js_string)
  end

end

module SeleniumHelper

  import SeleniumCommandShortcuts
  import TodoAssertion

  attr_reader :selenium

  $domain = ARGV[0]

  # == Start a new browser instance with no cookies or cached files.
  def setup
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      @selenium = Selenium::Client::Driver.new "localhost", 4444, "*firefox", $domain, 10000
      @selenium.start_new_browser_session
    end
    @selenium.set_context("selenium_helper")
  end

  # == Close the browser.
  def teardown
    @selenium.stop unless $selenium
    assert_equal [], @verification_errors
  end

end


class replaceClassJqueryTest < Test::Unit::TestCase

  include SeleniumHelper

  def test_click_each_button

    replace_bar_with_foo

  end

  private

# replace bar with foo on elements that already have class foo

#    $('li').replaceClass('foo', 'bar') 

  def replace_class
  end

# the same, but also append class bar to elements that have neither
# class foo nor bar

#    $('li').replaceClass('foo', 'bar', true) 

  def replace_or_assign_class
  end

# toggle elements that have class foo to class bar, and vice versa

#    $('li').toggleClass('foo', 'bar') 

  def toggle_class
  end

# the same, but also append class bar to elements that have neither class foo nor bar

#    $('li').toggleClass('foo', 'bar', true) 

  def toggle_or_assign_class
  end

end

