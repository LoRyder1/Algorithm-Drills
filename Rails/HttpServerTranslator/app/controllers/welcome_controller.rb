class WelcomeController < ApplicationController
  def index
    raise params.inspect
    @hello = "hello"
  end
end
