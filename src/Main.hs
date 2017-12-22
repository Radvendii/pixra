module Main where

import Protolude hiding (on)
import Graphics.UI.Gtk hiding (get)
import Diagrams.Prelude
import Diagrams.Backend.Gtk
import Diagrams.Backend.Cairo

runMainWindow :: Diagram B -> IO ()
runMainWindow dia = do
  let gdia = toGtkCoords dia
  void initGUI
  w <- windowNew
  da <- drawingAreaNew
  w `containerAdd` da

  void $ (w `on` deleteEvent) $ liftIO mainQuit >> return True
  
  void $ (da `on` exposeEvent) $ liftIO $ do
    dw <- widgetGetDrawWindow da
    renderToGtk dw gdia
    return True

  da `widgetAddEvents` [KeyPressMask]
  da `widgetSetCanFocus` True

  widgetShowAll w
  mainGUI

main :: IO ()
main = runMainWindow $ circle 40 # fc blue # bg black
