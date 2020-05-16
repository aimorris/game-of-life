module Main where

import Data.TraversableWithIndex (traverseWithIndex)

import Data.Maybe (fromJust)
import Effect (Effect)
import Graphics.Canvas (Context2D, getCanvasElementById, getContext2D)
import Graphics.Drawing (FillStyle, rectangle, fillColor, filled, render)
import Partial.Unsafe (unsafePartial)
import Prelude
import Color
import Color.Scale (sample)
import Color.Scale.Perceptual (magma)
import Data.Int (toNumber)
import Effect.Console
import Effect.Timer
import Data.Array
import Data.Maybe

type Board = Array (Array Int)

startingPosition :: Board
startingPosition =
  [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

main :: Effect Unit
main = do
  mcanvas <- getCanvasElementById "canvas"
  ctx <- getContext2D $ unsafePartial $ fromJust mcanvas

  loop startingPosition ctx

loop :: Board -> Context2D -> Effect Unit
loop board ctx = do
  _ <- traverseWithIndex (\i a -> traverseWithIndex (setCell ctx i) a) board
  _ <- setTimeout 1000 (loop board ctx)
  pure unit

nextGeneration :: Board -> Board
nextGeneration board = board

countNeighbours :: Board -> Int -> Int -> Int
countNeighbours board x y =
  (fromMaybe 0 $ getCell board (x - 1) (y - 1)) +
  (fromMaybe 0 $ getCell board (x - 1) (y)) +
  (fromMaybe 0 $ getCell board (x - 1) (y + 1)) +
  (fromMaybe 0 $ getCell board (x + 1) (y - 1)) +
  (fromMaybe 0 $ getCell board (x + 1) (y)) +
  (fromMaybe 0 $ getCell board (x + 1) (y + 1)) +
  (fromMaybe 0 $ getCell board (x) (y - 1)) +
  (fromMaybe 0 $ getCell board (x) (y + 1))


getCellStyle :: Int -> FillStyle
getCellStyle x = fillColor $ rgba active active active 1.0
  where active = (1 - x) * 255

getCell :: Board -> Int -> Int -> Maybe Int
getCell board x y = (fromMaybe [] (board!!x))!!y

setCell :: Context2D -> Int -> Int -> Int -> Effect Unit
setCell ctx rowIndex colIndex isActive = do
  render ctx $
    filled (getCellStyle isActive) $
      rectangle (mul cellSize $ toNumber colIndex) (mul cellSize $ toNumber rowIndex) (cellSize - spacing) (cellSize - spacing)
  where cellSize = 50.0
        spacing = 1.0
