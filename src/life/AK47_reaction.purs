module PatternAK47Reaction where

import Effect (Effect)
import Prelude (Unit)
import Engine (renderLife)

type Board = Array (Array Int)

patternAK47Reaction :: Board
patternAK47Reaction =
  [
    [0,0,0,0,0,1,0,0,0,0],
    [0,0,0,0,1,0,1,0,0,0],
    [0,0,0,1,0,0,0,1,0,0],
    [0,0,0,1,0,0,0,1,0,0],
    [0,0,0,1,0,0,0,1,0,0],
    [0,0,0,0,1,0,1,0,0,0],
    [0,0,0,0,0,1,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,1,1,0,0,0,0,0,0],
    [0,0,0,1,0,0,0,0,0,0],
    [1,1,1,0,0,0,0,0,1,1],
    [1,0,0,0,0,0,0,0,1,1]
  ]

main :: Effect Unit
main = do
  renderLife patternAK47Reaction