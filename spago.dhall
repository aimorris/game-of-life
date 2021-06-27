{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "aff"
  , "arrays"
  , "canvas"
  , "colors"
  , "drawing"
  , "effect"
  , "foldable-traversable"
  , "integers"
  , "js-timers"
  , "maybe"
  , "partial"
  , "prelude"
  , "psci-support"
  , "spec"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
