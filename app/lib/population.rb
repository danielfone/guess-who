class Population
  SizeError = Class.new StandardError

  MAX_POPULATION = 5000
  ATTRIBUTES = {
    'sex' =>          %w[xx       xy],
    'eyes' =>         %w[blue     brown        cyclops],
    'glasses' =>      %w[none     sunglasses   xray       prescription],
    'hairstyle' =>    %w[mullet   bald         updo       ringlets        dynamite],
    'face' =>         %w[eyeliner beard        rouge      sideburns       goatee     lipstick],
    'haircolour' =>   %w[brown    pink         orange     blonde          green      black   grey   white],
  }

  def initialize(size)
    @size = Integer(size)
    @current_id = 0
    raise_size_error if @size > MAX_POPULATION || @size < 1
  rescue ArgumentError
    raise_size_error
  end

  def build
    population << build_member until population.size == @size
    population.each { |p| p['id'] = @current_id += 1 }
  end

  def population
    @population ||= Set.new
  end

private

  def build_member
    ATTRIBUTES.each_with_object({}) do |(attr, options), hash|
      hash[attr] = options.sample
    end
  end

  def raise_size_error
    raise SizeError, "Population must be between 1 and #{MAX_POPULATION}"
  end

end
