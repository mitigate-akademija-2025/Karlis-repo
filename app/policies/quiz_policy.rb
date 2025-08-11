class QuizPolicy
  attr_reader :user, :quiz

  def initialize(user, quiz)
    @user = user
    @quiz = quiz
  end

  def index?
    @user = user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.admin? ? scope.all : scope.none
    end
  end
end