## Guess Who

* Rounds last 30 mins
* Points accumulate during round
* You can fetch and solve puzzles in parallel

## Scoring

* Optimal will be binary search, so optimal guesses is n^1/2 (i.e. log2(n))
* e.g. pop=100 : best=1  ; worst=100 ; optimal=6.64
* Score = if solved?
    population - guesses
else
     -log2(population)
end

## Population

* Size is dependent on difficulty
* Attributes are heterogenous
* Attributes get more fractured for a bigger pop

## API

GET /puzzles/[teamname]/new?difficulty=[x]
=> 302 /puzzles/[uuid]

--

GET /puzzles/[uuid]
{
    uuid: [uuid],
    population: {
        1: {hair: brown, eyes: blue, ...},
        2: {hair: brown, eyes: brown, ...},
        3: {...},
        ...,
    }
}

--

GET /puzzles/[uuid]/answer/[id]
=> 404 Wrong, keep guessing
=> 200 You Won!

--

GET /puzzles/[uuid]/answer?hair=brown
GET /puzzles/[uuid]/answer?hair=brown&eyes=blue
GET /puzzles/[uuid]/answer?query=any&hair=brown&..
=> 200/404

--

GET /scoreboard

Round   1       2
team1 score     x
team2 score     x

Queries
        val
attr    x

--

## Schema

Puzzle:
- uuid
- round
- difficulty
- team
- population
- answer_id
- guesses
- solved

For queries, keep puzzle (and answer) in identity map
