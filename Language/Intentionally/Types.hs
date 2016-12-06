module Language.Intentionally.Types where
import Data.Set (Set(..))
import qualified Data.Set as Set
-- User or device
newtype Agent = Agent (Set AState)
  deriving (Show, Eq, Ord)

data AState = AP Physics
            | AB Body
            | AI Instinct
            | AS Social
  deriving (Show, Eq, Ord)
-- abstraction of Reality based interface categories
data Physics
  deriving (Show, Eq, Ord)
data Body = Human | Device
  deriving (Show, Eq, Ord)
data Instinct
  deriving (Show, Eq, Ord)
data Social
  deriving (Show, Eq, Ord)

data Action
  deriving (Show, Eq, Ord)
  
data Intent a where
  -- informational
  Notify    :: String  -> Intent String
  Inform    :: String  -> Intent String
  -- actible
  Suggest   :: Action  -> Intent Action
  Command   :: Action  -> Intent Action
  -- interactable
  Query     :: Context -> Intext Context
  -- agent oriented
  Focus     :: Body     -> Intent Body
  Constrain :: Physics  -> Intent Physics
  Aware     :: Instinct -> Intent Instinct
  Relate    :: Social   -> Intent Social
  Learn     :: Agent    -> Intent Agent
  deriving (Show, Eq, Ord)


data Noise
  deriving (Show, Eq, Ord)
data Context = Context Agent Agent Intent
  deriving (Show, Eq, Ord)
data Meaning
  deriving (Show, Eq, Ord)
