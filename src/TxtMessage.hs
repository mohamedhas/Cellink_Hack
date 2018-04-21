{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module TxtMessage where

import Data.Aeson.Types
import GHC.Generics


type StringArray = [String]

data TxtMsg = TxtMsg {
  speech :: String,
  user :: String
} deriving (Show, Generic)

data DiagflowRequest = DiagflowRequest {
  contexts :: StringArray,
  lang :: String,
  query :: String ,
  sessionId :: String,
  timezone :: String
} deriving (Show, Generic)

diagTempalte speech = DiagflowRequest {contexts = ["shops"], lang = "en",
                                       query = speech, sessionId = "123",
                                       timezone = "America/New_York"}

data NLP = NLP {
  id :: String,
  timestamp :: String,
  langN :: String,
  result :: TxtMessage.Result,
  sessionIdN :: String,
  status :: Status
} deriving (Show, Generic)

instance FromJSON NLP where
    parseJSON = withObject "NLP" $ \v -> NLP
        <$> v .: "id"
        <*> v .: "timestamp"
        <*> v .: "lang"
        <*> v .: "result"
        <*> v .: "sessionId"
        <*> v .: "status"

data Result = Result {
  source :: String,
  resolvedQuery :: String,
  action :: String,
  actionIncomplete :: String ,
  parameters :: Parameters,
  contextsR :: [Contexts],
  metaData :: MetaData,
  fulfillment :: Fulfillment
} deriving (Show, Generic)

instance FromJSON TxtMessage.Result where
    parseJSON = withObject "result" $ \v -> Result
        <$> v .: "source"
        <*> v .: "resolvedQuery"
        <*> v .: "action"
        <*> v .: "actionIncomplete"
        <*> v .: "parameters"
        <*> v .: "contexts"
        <*> v .: "metaData"
        <*> v .: "fulfillment"

data Parameters = Parameters {
  organs :: String,
  organsOriginal :: String
} deriving (Show, Generic)

instance FromJSON Parameters where
    parseJSON = withObject "parameters" $ \v -> Parameters
        <$> v .: "organs"
        <*> v .: "organs.original"

data Contexts = Contexts {
  name :: String,
  parametersC :: Parameters,
  lifespan :: Int
} deriving (Show, Generic)

instance FromJSON Contexts where
    parseJSON = withObject "contexts" $ \v -> Contexts
        <$> v .: "name"
        <*> v .: "parameters"
        <*> v .: "lifespan"

data MetaData = MetaData {
  intentId :: String,
  webhookUsed :: String,
  webhookForSlotFillingUsed ::String,
  intentName :: String
} deriving (Show, Generic)

instance FromJSON MetaData
instance ToJSON MetaData

data Fulfillment = Fulfillment {
  speechF :: String,
  message :: Message,
  score :: Double
} deriving (Show, Generic)

instance FromJSON Fulfillment where
    parseJSON = withObject "fulfillment" $ \v -> Fulfillment
        <$> v .: "score"
        <*> v .: "speech"
        <*> v .: "message"

data Message = Message {
  typeM :: Int,
  speechM :: String
} deriving (Show, Generic)

instance FromJSON Message where
    parseJSON = withObject "message" $ \v -> Message
        <$> v .: "type"
        <*> v .: "speech"

data Status = Status {
  code :: Int,
  errorType :: String,
  webhookTimedOut :: Bool
} deriving (Show, Generic)

instance FromJSON Status
instance ToJSON Status


instance FromJSON TxtMsg
instance ToJSON TxtMsg

instance FromJSON DiagflowRequest
instance ToJSON DiagflowRequest
