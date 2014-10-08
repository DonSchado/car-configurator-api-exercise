class User < ActiveRecord::Base

  def limit
    {
      0 => Money.new(0, 'EUR'),
      1 => Money.new(120000, 'EUR'),
      2 => Money.new(80000, 'EUR'),
      3 => Money.new(60000, 'EUR'),
    }.fetch(level)
  end

  def allowed_package?(package)
    package_rules.include?(package) ? package : false
  end

  # level 1,2 allows to select p1 or p2
  # level 3 is p1
  def package_rules
    {
      1 => %w( p1 p2 ),
      2 => %w( p1 p2 ),
      3 => %w( p1 ),
    }.fetch(level)
  end
end
