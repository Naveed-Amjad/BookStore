class CommentPolicy < ApplicationPolicy

  def create?
    true  # Allow creation if the user is logged in (its implemetaion is pending)
  end

  def update?
    admin_user? || user_created_comment?
  end

  def destroy?
    admin_user? || user_created_comment?
  end

  private

  def admin_user?
    user&.admin? 
  end

  def user_created_comment?
    user == record.user
  end



  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
