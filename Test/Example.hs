module Test.Examples where


-- generic programming subroutine example
generic_ex1 :: Intly Agent
generic_ex1 =
  do
    u1   <- primary user
    p    <- current program
    ctxs <- current context
    checkIf (hasIntentFor ctxs) p u1 $
      (\i -> (case i of
                Notify msg  -> do
                  dAll <- every $ deviceWhere (can $ notify u1)
                  notifyWith d1 msg u1
                Inform msg  -> do
                  d1 <- some $ deviceWhere (can $ inform u1)
                  informWith d1 msg u1
                Suggest act -> do
                  d1 <- some $ deviceWhere (can $ inform u1)
                  d2 <- some $ deviceWhere (can $ performActionWith act u1)
                  informWith d1 ("Please use " ++ (show d2) ++ " to perform " ++ (show act)) u1
                  promise d2 act u1
                Command act -> do
                  d1 <- some $ deviceWhere (can $ notify u1)
                  d2 <- some $ deviceWhere (can $ performActionWith act u1)
                  notifyWith d1 ("Please use " ++ (show d2) ++ " to perform action, now") u1
                  waitFor d2 act u1
                Query   q   -> do
                  d1 <- some $ deviceWhere (can $ ask u1)
                  response <- (askWith d1 q u1)
                  improveContext u1 response
                Focus   b   -> do
                  d1 <- some $ deviceWhere (can $ makeContact b)
                  improveContext (Relate $ Personal d1 b)
                  dElse <- every $ deviceWhere (cant $ makeContact b)
                  improveContext $ remove (Relate $ dElse b)
                Constrain phy do
                  d1    <- some $ deviceWhere $ (withCertainty High) (affectedBy phy)
                  d2    <- some $ deviceWhere (can $ inform u1)
                  informWith d2 ((show d1) ++ " is impared by constraint: " ++ (show phy)) u1
                  un $ prioritize d1
                Aware instinct ->
                  case instinct of
                    Busy task -> do
                      dAll <- every $ deviceWhere (can $ helpWith task)
                      prioritize dAll
                    _         -> learn u1 instinct
                Relate social ->
                  dAll <-  every $ deviceWhere (can $ disrupt social)
                  un $ prioritize dAll
                _ -> learn nothing

            )
      )
    return program
