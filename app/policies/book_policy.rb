class BookPolicy < ApplicationPolicy

  def destroy?
    admin_user? || user_created_book?
  end

  def edit?
    admin_user?
  end

  def update?
    admin_user? || user_created_book?
  end

  private

  def admin_user?
    user&.admin?
  end

  def user_created_book?
    user == record.user
  end



  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
