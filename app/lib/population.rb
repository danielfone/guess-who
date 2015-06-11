class Population
  BuildError = Class.new StandardError

  MAX_POPULATION = 5000
  ATTRIBUTES = {
    sex:         [:xx,       :xy],
    eyes:        [:blue,     :brown,      :cyclops],
    glasses:     [:none,     :sunglasses, :xray,     :prescription],
    hairstyle:   [:mullet,   :bald,       :updo,     :ringlets,      :dynamite],
    face:        [:eyeliner, :beard,      :rouge,    :sideburns,     :goatee,   :lipstick],
    haircolour:  [:brown,    :pink,       :orange,   :blonde,        :green,    :black, :grey, :white],
  }

  def self.build(*args); new(*args).build; end

  def initialize(size)
    @size = Integer(size)
    @current_id = 0
    raise BuildError, "Population is too large. Max #{MAX_POPULATION}" if @size > MAX_POPULATION
  end

  def build
    population << build_member until population.size == @size
    population.each { |p| p[:id] = @current_id += 1 }
  end

  def population
    @population ||= Set.new
  end

private

  def build_member
    Population::ATTRIBUTES.each_with_object({}) do |(attr, options), hash|
      hash[attr] = options.sample
    end
  end

end
