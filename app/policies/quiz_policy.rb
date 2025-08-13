class QuizPolicy < ApplicationPolicy
  attr_reader :user, :quiz

  def initialize(user, quiz)
    @user = user
    @quiz = quiz
  end

  def index?
    @user = user
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
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

  private

  def user_is_owner_or_admin?
    user.admin? || record.user_id == user.id
  end
end