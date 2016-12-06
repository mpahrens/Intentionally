{-#LANGUAGE GADTs #-}
module Language.Intentionally.Free where

import Language.Intentionally.Types

import Control.Monad.Free

-- syntax

data IExp a next where
  Program    :: (IVal Agent -> next) -> IExp Agent next
  Context   :: (IVal Context -> next) -> IExp Context next
  NotifyWith :: ...
  Some       :: ...
  Every      :: ...
  Can        :: ...
  Cant       :: ...
  ...

type Intly a = Free (IExp a ())


data IVal a where
  AgentV   :: Agent   -> IVal Agent
  ActionV  :: Action  -> IVal Action
  IntentV  :: Intent  -> IVal Intent
  NoiseV   :: Noise   -> IVal Noise
  ContentV :: Context -> IVal Context
  MeaningV :: Meaning -> IVal Meaning
