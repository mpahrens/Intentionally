module Language.Intentionaly.Interpreter where

  toJava :: Intly Agent -> [Java Class]
  toJava (Free (Program g) = do
    jr <- javaRef "program"
    a <- getAgentFor jr
    toJava $ g a -- give agent back, recurse
  toJava (Free (Context c)) = ...
  toJava (Free (NotifyWith _ _ )) = ...
