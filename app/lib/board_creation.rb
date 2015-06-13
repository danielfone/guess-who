class BoardCreation
  DEFAULT_SIZE = 24

  def self.perform(*args); new(*args).perform; end

  def initialize(team, size)
    @team       = String(team) or raise "Team is required"
    @size = size || DEFAULT_SIZE
    @population = Population.new @size
  end

  def perform
    Board.create! do |p|
      p.team = @team
      p.size = @size
      p.population = generated_population
      p.answer = generated_population.sample
    end
  end

private

  def generated_population
    @generated_population ||= @population.build.to_a
  end

end
