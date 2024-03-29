class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def admin?
    user.admin?
  end

  def show?
    record.user == user
  end

  def detail?
    user.admin?
  end

  def create?
    true
  end

  def paiement?
    true
  end
end
