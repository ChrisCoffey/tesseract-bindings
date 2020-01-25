module Main where

import Protolude

import Tesseract.Bindings
import Foreign.C.String

main :: IO ()
main = do
    s <- newCString "Test"
    putStrLn ("Not implemented" :: Text)
