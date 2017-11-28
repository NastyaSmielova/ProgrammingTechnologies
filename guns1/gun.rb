# for longrange enumaration
module LONGRANGE
  NEARBY = 'nearby'.freeze
  MEDIUM = 'medium'.freeze
  LONG = 'long'.freeze
end

# for handy enumaration
module HANDY
  TWO = 'two'.freeze
  ONE = 'one'.freeze
end


# complex type ttc
class TTC
  #attr_reader :handy
  attr_reader :effectiveRange, :longrange
  attr_accessor  :opticsPresense , :cagePresense
  def longrange=(longrange)
    if (longrange == LONGRANGE::NEARBY) || (longrange == LONGRANGE::MEDIUM)|| (longrange == LONGRANGE::LONG)
      @longrange = longrange
    else
      raise('not appropriate longrange ')
    end
  end

  def effectiveRange=(effectiveRange)
    if effectiveRange.match(/\A[+-]?\d+?(\.\d+)?\Z/)
      @effectiveRange = effectiveRange
    else
      raise('not appropriate effectiveRange ')
    end
  end


  def to_s
    " longrange: #{@longrange},  effectiveRange: #{@effectiveRange} , opticsPresense: #{@opticsPresense} , cagePresense: #{@cagePresense}"
  end
end

class Gun
  attr_accessor :material,:origin, :model, :TTC
  attr_reader :handy
  def handy=(handy)
    if (handy == HANDY::ONE) || (handy == HANDY::TWO)
        @handy = handy
      else
        raise('not appropriate handy :' + handy + HANDY::ONE + HANDY::TWO)

      end
    end

  def to_s
    "material: #{@material}, Origin: #{@origin}, TTC: #{@TTC}, handy: #{@handy}, Model: #{@model}"
  end
end
