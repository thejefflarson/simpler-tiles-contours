require 'rubygems'
require 'simpler_tiles'

ROOT = File.expand_path(File.dirname(__FILE__))

map = SimplerTiles::Map.new do |m|
  m.srs     = "EPSG:3083"
  m.bgcolor = "#ffffff"
  m.width   = 423
  m.height  = 260
  m.set_bounds(-585080.885134, 6849466.721081, 4161303.603672, 9587780.816356)

  Dir["#{ROOT}/data/*.shp"].each do |shp|
    m.layer shp do |l|
      l.query "select * from '#{File.basename shp, '.shp'}'" do |q|
        q.styles "stroke" => "#11111166",
              "line-join" => "round",
                 "weight" => "0.1"
      end
    end
  end
end

File.open("#{ROOT}/out.png", 'w') {|f| f.write map.to_png }
