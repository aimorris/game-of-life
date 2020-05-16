module Main where

import Effect (Effect)
import Prelude (Unit)
import Engine (renderLife)

type Board = Array (Array Int)

startingPosition :: Board
startingPosition =
  [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 1, 0, 0, 0, 0],
    [0, 0, 1, 0, 1, 0, 0, 0, 0],
    [0, 1, 0, 0, 1, 0, 1, 1, 0],
    [0, 1, 1, 0, 1, 0, 0, 1, 0],
    [0, 0, 1, 0, 1, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

main :: Effect Unit
main = do
  renderLife startingPosition