class User < ActiveRecord::Base

  def limit
    {
      0 => Money.new(0, 'EUR'),
      1 => Money.new(120000, 'EUR'),
      2 => Money.new(80000, 'EUR'),
      3 => Money.new(60000, 'EUR'),
    }.fetch(level)
  end
end
