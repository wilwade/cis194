{-# OPTIONS_GHC -Wall #-}
module Cis194.Hw.LogAnalysis where

-- in ghci, you may need to specify an additional include path:
-- Prelude> :set -isrc/Cis194/Hw
import  Cis194.Hw.Log

parseWarning :: [String] -> LogMessage
parseWarning (t:m) = (LogMessage Warning (read t) (unwords m))

parseInfo :: [String] -> LogMessage
parseInfo (t:m) = (LogMessage Info (read t) (unwords m))

parseError :: [String] -> LogMessage
parseError (s:t:m) = (LogMessage (Error (read s)) (read t) (unwords m))

parseMessage :: String -> LogMessage
parseMessage (t:s)
  | t == 'I' = parseInfo (words s)
  | t == 'W' = parseWarning (words s)
  | t == 'E' = parseError (words s)
  | otherwise = Unknown (t:s)

parse :: String -> [LogMessage]
parse x = [parseMessage l | l <- (lines x)]

insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) t = t
insert x Leaf = Node Leaf x Leaf
insert x@(LogMessage _ ts _) t@(Node l n@(LogMessage _ nts _) r)
  | ts <= nts = Node (insert x l) n r
  | ts > nts = Node l n (insert x r)

build :: [LogMessage] -> MessageTree
build _ = Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder _ = []

-- whatWentWrong takes an unsorted list of LogMessages, and returns a list of the
-- messages corresponding to any errors with a severity of 50 or greater,
-- sorted by timestamp.
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong _ = []
