class QuizPolicy < ApplicationPolicy
  def index?
    true # Allow all users to view the list of quizzes
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
      user.admin? ? scope.all : scope.where(user_id: user.id)
    end
  end

  private

  def user_is_owner_or_admin?
    user.present? && record.present? && (user.admin? || record.user_id == user.id)
  end
end