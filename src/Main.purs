module Main where

import Prelude (Unit, bind, map, (/=))

import Effect (Effect)
import Graphics.Canvas (getCanvasElementById, getContext2D)
import Partial.Unsafe (unsafePartial)
import Data.Maybe (fromJust)
import Effect.Console (log)

main :: Effect Unit
main = do
  mcanvas <- getCanvasElementById "canvas"
  let canvas = unsafePartial (fromJust mcanvas)
  ctx <- getContext2D canvas
  
  log "test"

startingPosition :: Array (Array Boolean)
startingPosition = map (map (_ /= 0))
  [
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1]
  ]
