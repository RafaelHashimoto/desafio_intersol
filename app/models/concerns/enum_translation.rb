module EnumTranslation
  extend ActiveSupport::Concern

  def t_enum(enum)
    I18n.t "activerecord.attributes.#{self.class.name.underscore}.enums.#{enum}.#{self.send(enum)}"
  end
end