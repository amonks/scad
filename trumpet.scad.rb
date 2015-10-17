def cones(total, radius_start, radius_end, height, thickness)
  height_each = height / total
  radii = (1..total).map{|i| (i ** 2) / 10.0}
  out = ""
  radii.each.with_index do |radius, i|
    x = (i / total) * height
    next_radius = ((x + 2) ** 2) / 10.0
    out += %Q|
      difference () {
        #{cone(i * height_each, height_each, radius, next_radius)}
        #{cone(i * height_each, height_each, radius - thickness, next_radius - thickness)}
      }
    |
  end
  out
end

def cone(z, height, start_radius, end_radius)
  %Q|
    translate([0, 0, #{z}])
      linear_extrude(height = #{height}, center = false, convexity = 10, twist = 0, $fn = 50, scale = #{end_radius / start_radius})
      circle(r = #{start_radius});
  |
end

puts cones(10, 1.0, 5.0, 40.0, 0.2)
