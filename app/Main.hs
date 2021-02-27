{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib ()
import Player
import SDL
import Linear (V4(..))
import Control.Monad (unless)
import qualified Data.Map as Map

main :: IO ()
main = do
  initializeAll
  window <- createWindow "Eat Butts..." defaultWindow
  renderer <- createRenderer window (-1) defaultRenderer
  appLoop renderer
  destroyWindow window

appLoop :: Renderer -> IO ()
appLoop renderer = do
  -- Make a fuckin' player
  let player = Player {
    position = (20, 20),
    health = 10
  }
  -- Tell SDL to poll the fucking events.
  pollEvents 

  -- Grab some keeb states, cuz fucking why not?
  keyMap <- getKeyboardState
  let qPressed = keyMap ScancodeQ
  
  rendererDrawColor renderer $= V4 0 0 255 255
  clear renderer
  present renderer
  unless qPressed (appLoop renderer)

eventIsQPress :: Event -> Bool
eventIsQPress event = 
  case eventPayload event of
    KeyboardEvent keyboardEvent ->
      keyboardEventKeyMotion keyboardEvent == Pressed &&
      keysymKeycode (keyboardEventKeysym keyboardEvent) == KeycodeQ
    _ -> False
