class PuzzleCreation
  DEFAULT_DIFFICULTY = 10

  def self.perform(*args); new(*args).perform; end

  def initialize(team, difficulty)
    @team       = String(team) or raise "Team is required"
    @difficulty = difficulty || DEFAULT_DIFFICULTY
    @population = Population.new @difficulty
  end

  def perform
    Puzzle.create! do |p|
      p.team = @team
      p.difficulty = @difficulty
      p.population = generated_population
      p.answer = generated_population.sample
    end
  end

private

  def generated_population
    @generated_population ||= @population.build.to_a
  end

end
