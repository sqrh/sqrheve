# encoding: UTF-8
class Wormhole
  include MongoMapper::Document
  many :comments, :as => :commentable
  key :name, String
  key :scs, Array
  key :planets, Array
  key :climate, String
  key :cls, Integer
  timestamps!

  def trans_pl(p, i)
    p = p.gsub 'Planet', "行星#{i}"
    p = p.gsub 'Barren', '贫瘠'
    p = p.gsub 'Plasma', '等离子'
    p = p.gsub 'Temperate', '温和'
    p = p.gsub 'Gas', '气体'
    p = p.gsub 'Lava', '熔岩'
    p = p.gsub 'Ice', '冰体'
    p = p.gsub 'Oceanic', '海洋'
    p = p.gsub 'Storm', '风暴'
  end

  def get_climate_affects
    Climate.where(:name => self.climate, :cls => self.cls).first.affects
  end

  def get_info
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://www.staticmapper.com/index.php?system="+self.name))
    lists = doc.css('.categoryitems>li')
    if lists.count == 0
      return false
    else
      planet = ''
      i = 0
      lists.each do |lst|
        if lst.attributes["class"].value=='moonpad '
          planet += ': 卫星 X '+lst.css('li').count.to_s
        else
          if planet.length > 0
            i += 1
            planet = trans_pl(planet, i)
            self.planets.push(planet)
            self.save
          end
          planet = lst.css('img')[0].attributes['alt'].value
        end
      end
      if planet.length > 0
	i += 1
	planet = trans_pl(planet, i)
	self.planets.push(planet)
	self.save
      end
      return true
    end
  end

  def scs_in_string
    scs.reduce{|a,b|"#{a},#{b}"}
  end

  def scs_in_string=(s)
    self.scs = s.split(",")
  end

  def rpi
    false
  end

  def rpi=(flag)
    if flag.to_s=="1"
      puts flag
      puts "Planets Info Reseted"
      self.planets = []
    end
  end

end
