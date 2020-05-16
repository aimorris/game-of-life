module Main where

import Data.TraversableWithIndex (traverseWithIndex)

import Data.Maybe (fromJust)
import Effect (Effect)
import Graphics.Canvas (Context2D, getCanvasElementById, getContext2D)
import Graphics.Drawing (FillStyle, circle, fillColor, filled, render)
import Partial.Unsafe (unsafePartial)
import Prelude (Unit, bind, map, ($), (*), (+), (/=))
import Color.Scale (sample)
import Color.Scale.Perceptual (magma)
import Data.Int (toNumber)

startingPosition :: Array (Array Boolean)
startingPosition = map (map (_ /= 0))
  [
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1]
  ]

main :: Effect (Array (Array Unit))
main = do
  mcanvas <- getCanvasElementById "canvas"
  let canvas = unsafePartial (fromJust mcanvas)
  ctx <- getContext2D canvas

  traverseWithIndex (\i a -> traverseWithIndex (drawCell ctx i) a ) startingPosition

getCellStyle :: Boolean -> FillStyle
getCellStyle x = (fillColor $ sample magma 3.0)

drawCell :: Context2D -> Int -> Int -> Boolean -> Effect Unit
drawCell ctx rowIndex colIndex isActive = do
  render ctx $
    filled (getCellStyle isActive) (circle (50.0 * (toNumber rowIndex) + 25.0) (50.0 * (toNumber colIndex) + 25.0) 25.0)
