module VotesHelper
  def get_poll_for_proposal(proposal)
    Poll.find(proposal.poll_id)
  end

  def get_item_for_proposal(proposal)
    Item.find(proposal.item_id)
  end

  # TODO: Use real I18N
  def translate_preference(preference)
    pref = preference.to_sym

    case pref
    when :very_positive
      'Mein Favorit'
    when :positive
      'Gerne'
    when :neutral
      'Ist OK'
    when :negative
      'Eher nicht'
    when :very_negative
      'Auf keinen Fall'
    when :unknown
      'Unbekannter Wert'
    else
      ''
    end
  end

  def colorize_preference(preference)
    pref = preference.to_sym

    case pref
    when :very_positive
      '#5f5'
    when :positive
      '#bfb'
    when :neutral
      '#eee'
    when :negative
      '#fbb'
    when :very_negative
      '#f55'
    when :unknown
      '#fff'
    else
      '#fff'
    end
  end
end
