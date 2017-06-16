module ApplicationHelper

  def yesno(x)
    x ? I18n.t('yes') : I18n.t('no')
  end

  def is_checked(x)
    x ? '✔︎' : '✗'
  end

end
