class PuzzleCreation
  include ActiveModel::Model

  DEFAULT_DIFFICULTY = 10

  attr_reader :team, :difficulty

  validates_presence_of :team

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
      p.population = generated_population
      p.answer_id = generated_population.keys.sample
    end
  end

  def generated_population
    @generated_population ||= {
      'id' => { foo: 'bar' }
    }
  end

end
