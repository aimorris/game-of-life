module Test.Main where

import Prelude

import Main (getCell, countNeighbours)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

import Data.Maybe

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "getCell" do
    it "Element exists" $ getCell sampleArray1 0 1 `shouldEqual` (Just 0)
    it "Element exists" $ getCell sampleArray1 2 2 `shouldEqual` (Just 1)
    it "Element non-existent" $ getCell sampleArray1 0 3 `shouldEqual` Nothing
    it "Element non-existent" $ getCell sampleArray1 10 3 `shouldEqual` Nothing
  describe "countNeighbours" do
    it "2 neighbours" $ countNeighbours sampleArray1 1 1 `shouldEqual` 2
  where sampleArray1 = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
