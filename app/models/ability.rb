class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def admin_abilities
    can :manage, :all
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities

    can :create, [Question, Answer]
    can [:update, :destroy], [Question, Answer], user: user

    can [:set_best], Answer do |answer|
      answer.question.user == user && !answer.best_answer
    end

    can [:cancel_best], Answer do |answer|
      answer.question.user == user && answer.best_answer
    end

    can :destroy, Attachment, attachable: { user: user }

    can :read, Role

  end

end
