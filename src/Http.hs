module Http where

import           Network.HTTP.Simple
import           Data.Aeson
import qualified Data.ByteString.Char8 as B
import Network.HTTP.Types.Header
import TxtMessage
{-
getResponse req = withSocketsDo $ do
               res <- withManager $ H.httpLbs req
               let body = C.unpack . responseBody $ res
               return body
-}

postR :: (ToJSON b) => String -> b -> String -> IO (Response NLP)
postR url json token = do
    let request = setRequestBodyJSON json
            $ addRequestHeader hContentType (B.pack "application/json")
            $ addRequestHeader hAuthorization (B.pack $ "Bearer " ++ token)
            $ parseRequest_ url
    httpJSON request

postR_ url json token = do
    let request = setRequestBodyJSON json
            $ addRequestHeader hContentType (B.pack "application/json")
            $ addRequestHeader hAuthorization (B.pack $ "Bearer " ++ token)
            $ setRequestMethod (B.pack "POST")
            $ parseRequest_ url
    httpBS request
