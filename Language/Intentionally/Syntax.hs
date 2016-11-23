module Language.Intentionally.Syntax where

data IDec = IExpD IExp

data IExp = IValE IVal

data IVal = IUserV User
          | IActionV Action
          | IIntentV Intent
          | INoiseV Noise
          | IContextV Context
          | IMeaningV Meaning


data User

data Action

data Intent

data Noise

data Context

data Meaning
