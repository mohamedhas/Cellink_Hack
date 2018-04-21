{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where
import Web.Scotty     (ActionM, scotty, get, post, liftAndCatchIO,
                                    json, rescue, html, param, jsonData)
import Data.Aeson.Types
import TxtMessage
import Data.Text.Lazy
import Http
import Network.HTTP.Simple as S
import qualified Data.ByteString.Char8 as B8

-- the program will recivie a json object, parse it and then it will process it
url   = "https://api.dialogflow.com/v1/query?v=20150910"
token = "54b461a811ce4738a72f93b3b86d0541"

data MsgResponse = MsgResponse {
    flag :: Bool,
    msg :: String
}

process :: String -> MsgResponse
process "assistant" = MsgResponse {flag = True, msg = "Hello"}

main :: IO ()
main = scotty 3000 $ do
    get "/" serve
    post "/" serve
  where
    serve :: ActionM ()
    serve = do
      rslt <- jsonData :: ActionM TxtMsg
      liftAndCatchIO $ putStrLn $ show rslt
      liftAndCatchIO $ do
          response <- postR url (toJSON $ diagTempalte $ speech rslt) token
          B8.putStrLn $ getResponseBody response
