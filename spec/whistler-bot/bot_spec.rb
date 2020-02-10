# frozen_string_literal: true

require 'spec_helper'

describe WhistlerBot::Bot do
  def app
    WhistlerBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'
end
