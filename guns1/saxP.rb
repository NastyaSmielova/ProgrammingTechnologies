require 'nokogiri'
include Nokogiri

require_relative 'gun'

include Nokogiri

class SAX < Nokogiri::XML::SAX::Document
  attr_reader :guns

  def initialize
    @guns = nil
    @elem = nil
  end

  def start_document
    @guns = Array.new
  end


  def start_element(name, attributes)
    if name == 'Gun'
      @elem = Gun.new
      @ttc = TTC.new
    end
    @state = name
  end

  def end_element(name)
    if name == 'Gun'
      @elem.TTC = @ttc

      @guns.push(@elem)
    end
    @state = nil
  end


  def end_document
    puts "\n \nSax parser :\n"
    puts(guns)

    puts "\n Sax parser sorted:\n"
    puts(guns.sort_by(&:origin))

  end

  def characters(value)
    case @state
      when 'Material'
        @elem.material = value
      when 'LongRange'
        @ttc.longrange = value
      when 'CagePresense'
        @ttc.cagePresense = value
      when 'OpticsPresense'
        @ttc.opticsPresense = value
      when 'EffectiveRange'
        @ttc.effectiveRange = value
      when 'Model'
        @elem.model = value
      when 'Handy'
        @elem.handy = value
      when 'Origin'
        @elem.origin = value
    end
  end

end