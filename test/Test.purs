module Test.Main where

import Prelude

import Main (getCell)
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
    it "Element exists" $ getCell sampleArray 0 1 `shouldEqual` (Just 0)
    it "Element exists" $ getCell sampleArray 2 2 `shouldEqual` (Just 1)
    it "Element non-existent" $ getCell sampleArray 0 3 `shouldEqual` Nothing
    it "Element non-existent" $ getCell sampleArray 10 3 `shouldEqual` Nothing
    where sampleArray = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
