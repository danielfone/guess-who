## Guess Who

  * Just like the board game, try to guess the correct "person" by asking yes or no questions.
  * You can only solve one board at a time.
  * Solved boards are scored according to how many questions/guesses they took (`size / questions`)

## API

Get a new board for your team. `size` can be ommitted, the default is 24 people.
To keep things scalable people have `id`s instead of names.
If your team has an existing unsolved board, this will be returned instead.

    GET /boards/[teamname]/new?size=3
    {
      "id": "867c3260-5257-4a8a-b550-be4f49d38a71",
      "size": 3,
      "population": [
        {
          "sex": "xy",
          "eyes": "brown",
          "glasses": "sunglasses",
          "hairstyle": "bald",
          "face": "goatee",
          "haircolour": "pink",
          "id": 59
        },
        {
          "sex": "xy",
          "eyes": "brown",
          "glasses": "sunglasses",
          "hairstyle": "dynamite",
          "face": "goatee",
          "haircolour": "orange",
          "id": 60
        },
        {
          "sex": "xy",
          "eyes": "brown",
          "glasses": "sunglasses",
          "hairstyle": "ringlets",
          "face": "goatee",
          "haircolour": "blonde",
          "id": 83
        }
      ],
      "team": "green-team"
    }

To implement the query interface, we misuse some HTTP status codes.

Ask about the selected person:

    GET /boards/[board_id]/person?hair=brown
    => 200 Yes, the person has brown hair
    => 204 No, the person does NOT have brown hair


Ask if the person has *any* of the following attributes

    GET /boards/[board_id]/person?hair=brown&eyes=blue
    => 200 The person has brown hair and/or blue eyes
    => 204 The person has neither brown hair nor blue eyes

Guess the person:

    GET /boards/[board_id]/person/[answer_id]
    => 204 Wrong, keep guessing
    => 200 You Won! Grab another board

## TODO:

  * [x] Validations on board creation
  * [x] Scoreboard
  * [x] Much faster lookups
  * [ ] Rounds
