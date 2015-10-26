require_relative 'solid.rb'

module RB_Scad
  def distance p1, p2
    axes = p1.length
    Math.sqrt(
      (0 .. axes - 1)
        .map{|a| p1[a] - p2[a] ** 2}
        .reduce(:+)
        .abs
    )
  end
end
