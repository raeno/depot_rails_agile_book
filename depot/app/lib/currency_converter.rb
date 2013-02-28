module CurrencyConverter

  EURO_LOCALES = [:es, :fr, :de]

  def self.usd_to_euro_course
    0.761092929
  end

  def from_usd(value,locale)
    if CurrencyConverter::EURO_LOCALES.include? locale
      value * CurrencyConverter.usd_to_euro_course
    else
      value
    end
  end



end