class PaintingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

    def create?
      record.user == user && user.admin
    end
  end
end
