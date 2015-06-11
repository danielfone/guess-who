class PuzzleCreation
  include ActiveModel::Model

  DEFAULT_DIFFICULTY = 10

  attr_reader :team, :difficulty

  validates_presence_of :team
  validates_numericality_of :difficulty

  def self.perform(*args); new(*args).perform; end

  def initialize(team, difficulty)
    @team       = String(team)
    @difficulty = Integer(difficulty || DEFAULT_DIFFICULTY)
  end

  def perform
    return unless valid?

    puzzle.save
    puzzle
  end

private

  def puzzle
    @puzzle ||= Puzzle.new do |p|
      p.team = team
      p.difficulty = difficulty
      p.population = generated_population.to_a
      p.answer = generated_population.to_a.sample
    end
  end

  def generated_population
    @generated_population ||= Population.build difficulty
  end

end
