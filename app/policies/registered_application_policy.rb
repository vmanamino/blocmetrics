class RegisteredApplicationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(id: record.id) && (user.present? && record.user == user)
  end
end
