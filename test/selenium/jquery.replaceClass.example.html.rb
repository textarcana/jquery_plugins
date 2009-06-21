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
  def window 
    'this.browserbot.getCurrentWindow().'
  end

  # == Prepend some stringified JavaScript with a reference to the window object of the Application Under Test.
  def js_get(js_string)
    return @selenium.js_eval(window + js_string)
  end

end

module SeleniumHelper

  include SeleniumCommandShortcuts
  include TodoAssertion

  attr_reader :selenium

  # == Start a new browser instance with no cookies or cached files.
  def setup
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      # server_host, server_port, browser_string, browser_url, timeout_in_seconds=300
      @selenium = Selenium::Client::Driver.new "localhost", 4444, "*chrome", "http://localhost", 10000
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


class ReplaceClassJqueryTest < Test::Unit::TestCase

  include SeleniumHelper

  def test_example_html

    load_aut

    assert_equal @selenium.title, "replaceClass jQuery plugin example", "page title"

    assert @selenium.get_expression(js_get(%{$().jquery}).match(/(\d+\.?){3}/)), "jQuery version string format"


    replace_class

    replace_or_assign_class

    toggle_class

    toggle_or_assign_class

  end

  private

  def load_aut
    @selenium.open "/~noah/jquery_plugins/jquery.replaceClass.example.html"
  end

  def click_button button_index, &block

    load_aut

    @selenium.get_expression(js_get(%{$('button')[#{button_index}].onclick()}))

    yield

  end

  # replace bar with foo on elements that already have class foo

  #    $('li').replaceClass('foo', 'bar') 

  def replace_class

    click_button 1 do

      assert_equal 0, @selenium.get_expression(js_get %{$('.foo').length}).to_i, "no elements with classname foo"

      assert_equal 2, @selenium.get_expression(js_get %{$('.bar').length}).to_i, "some elements with classname bar"

    end

  end

  # the same, but also append class bar to elements that have neither
  # class foo nor bar

  #    $('li').replaceClass('foo', 'bar', true) 

  def replace_or_assign_class

    click_button 2 do

      assert_equal 0, @selenium.get_expression(js_get %{$('.foo').length}).to_i, "no elements with classname foo"

      assert_equal 3, @selenium.get_expression(js_get %{$('.bar').length}).to_i, "some elements with classname bar"      

    end

  end

  # toggle elements that have class foo to class bar, and vice versa

  #    $('li').toggleClass('foo', 'bar') 

  def toggle_class

    click_button 3 do

      assert_equal 0, @selenium.get_expression(js_get %{$('#hasFoo').class}), "#hasFoo has class bar instead"

      
    end

  end

  # the same, but also append class bar to elements that have neither class foo nor bar

  #    $('li').toggleClass('foo', 'bar', true) 

  def toggle_or_assign_class
  end

end

