module Engine where

import Data.Maybe (Maybe, fromJust, fromMaybe)
import Color (rgba)
import Data.Array (mapWithIndex, (!!))
import Data.Int (toNumber)
import Data.TraversableWithIndex (traverseWithIndex)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Timer (setTimeout)
import Graphics.Canvas (Context2D, getCanvasElementById, getContext2D)
import Graphics.Drawing (FillStyle, rectangle, fillColor, filled, render)
import Partial.Unsafe (unsafePartial)
import Prelude (Unit, bind, mul, pure, unit, ($), (*), (+), (-))

type Board = Array (Array Int)
type Pos = Tuple Int Int

renderLife :: Board -> Effect Unit
renderLife pattern = do
  mcanvas <- getCanvasElementById "canvas"
  ctx <- getContext2D $ unsafePartial $ fromJust mcanvas
  
  loop pattern ctx

loop :: Board -> Context2D -> Effect Unit
loop board ctx = do
  _ <- traverseWithIndex (\x a -> traverseWithIndex (\y -> drawCells ctx (Tuple x y)) a) board
  _ <- setTimeout 500 (loop (nextGeneration board) ctx)
  pure unit

nextGeneration :: Board -> Board
nextGeneration board = mapWithIndex (\x a -> mapWithIndex (\y cell -> lives board (Tuple x y) cell) a) board

lives :: Board -> Pos -> Int -> Int
lives board pos current = case Tuple (countNeighbours board pos) (current) of
  Tuple 0 1 -> 0
  Tuple 1 1 -> 0
  Tuple 2 1 -> 1
  Tuple 3 _ -> 1
  _ -> 0

countNeighbours :: Board -> Pos -> Int
countNeighbours board (Tuple x y) =
  (fromMaybe 0 $ getCell board (Tuple (x - 1) (y - 1))) +
  (fromMaybe 0 $ getCell board (Tuple (x - 1) (y))) +
  (fromMaybe 0 $ getCell board (Tuple (x - 1) (y + 1))) +
  (fromMaybe 0 $ getCell board (Tuple (x + 1) (y - 1))) +
  (fromMaybe 0 $ getCell board (Tuple (x + 1) (y))) +
  (fromMaybe 0 $ getCell board (Tuple (x + 1) (y + 1))) +
  (fromMaybe 0 $ getCell board (Tuple (x) (y - 1))) +
  (fromMaybe 0 $ getCell board (Tuple (x) (y + 1)))


getCellStyle :: Int -> FillStyle
getCellStyle x = fillColor $ rgba active active active 1.0
  where active = (1 - x) * 255

getCell :: Board -> Pos -> Maybe Int
getCell board (Tuple x y) = (fromMaybe [] (board!!x))!!y

drawCells :: Context2D -> Pos -> Int -> Effect Unit
drawCells ctx (Tuple x y) isActive = do
  render ctx $
    filled (getCellStyle isActive) $
      rectangle (mul cellSize $ toNumber y) (mul cellSize $ toNumber x) (cellSize - spacing) (cellSize - spacing)
  where cellSize = 50.0
        spacing = 1.0
