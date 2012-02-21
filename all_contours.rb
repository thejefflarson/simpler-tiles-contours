require 'rubygems'
require 'simpler_tiles'

ROOT = File.expand_path(File.dirname(__FILE__))

map = SimplerTiles::Map.new do |m|
  m.srs     = "EPSG:3083"
  m.bgcolor = '#aad5f2'
  m.width   = 423
  m.height  = 260
  m.set_bounds(-585080.885134, 6849466.721081, 4161303.603672, 9587780.816356)


  m.layer "data/10m_coastline.shp" do |l|
    l.query 'select * from "10m_land"' do |q|
      q.styles 'fill' => '#ffffff',
           'seamless' => 'true',
             'stroke' => '#ffffff',
             'weight' => '0.1'
    end
  end

  Dir["#{ROOT}/data/*.shp"].each do |shp|
    m.layer shp do |l|
      l.query "select * from '#{File.basename shp, '.shp'}'" do |q|
        q.styles "stroke" => "#111111",
              "line-join" => "round",
                 "weight" => "0.1"
      end
    end
  end

end

File.open("#{ROOT}/out.png", 'w') {|f| f.write map.to_png }
