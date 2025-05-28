module Enterprise::Concerns::User
  extend ActiveSupport::Concern

  included do
    before_validation :ensure_installation_pricing_plan_quantity, on: :create

    has_many :captain_responses, class_name: 'Captain::AssistantResponse', dependent: :nullify, as: :documentable
    has_many :copilot_threads, dependent: :destroy_async
    has_many :copilot_messages, dependent: :destroy_async
  end

  # def ensure_installation_pricing_plan_quantity
  #   return unless ChatwootHub.pricing_plan == 'premium'

  #   errors.add(:base, 'User limit reached. Please purchase more licenses from super admin') if User.count >= ChatwootHub.pricing_plan_quantity
  # end

  # Alterando limit para 1000 usuários
  # e removendo verificação de plano de preços
  # para permitir que o super admin gerencie a quantidade de usuários
  # e não seja necessário comprar mais licenças.
  def ensure_installation_pricing_plan_quantity
    if User.count >= 1000
    errors.add(:base, 'User limit reached. Please purchase more licenses from super admin')
    end
  end
end
