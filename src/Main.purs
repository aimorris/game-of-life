module Main where

import Data.TraversableWithIndex (traverseWithIndex)

import Data.Maybe (fromJust)
import Effect (Effect)
import Graphics.Canvas (Context2D, getCanvasElementById, getContext2D)
import Graphics.Drawing (FillStyle, rectangle, fillColor, filled, render)
import Partial.Unsafe (unsafePartial)
import Prelude (Unit, bind, map, ($), (*), (+), (/=), (-))
import Color
import Color.Scale (sample)
import Color.Scale.Perceptual (magma)
import Data.Int (toNumber)

startingPosition :: Array (Array Int)
startingPosition =
  [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

main :: Effect (Array (Array Unit))
main = do
  mcanvas <- getCanvasElementById "canvas"
  let canvas = unsafePartial (fromJust mcanvas)
  ctx <- getContext2D canvas

  traverseWithIndex (\i a -> traverseWithIndex (drawCell ctx i) a ) startingPosition

getCellStyle :: Int -> FillStyle
getCellStyle x = fillColor $ rgba active active active 1.0
  where active = ((1 - x) * 255)

drawCell :: Context2D -> Int -> Int -> Int -> Effect Unit
drawCell ctx rowIndex colIndex isActive = do
  render ctx $
    filled (getCellStyle isActive) (rectangle (cellSize * (toNumber rowIndex)) (cellSize * (toNumber colIndex)) (cellSize - spacing) (cellSize - spacing))
  where cellSize = 50.0
        spacing = 1.0
