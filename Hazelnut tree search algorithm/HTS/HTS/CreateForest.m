function Trees = CreateForest (AlgorithmParams, ProblemParams)
VarMinMatrix = repmat(ProblemParams.VarMin,AlgorithmParams.NumOfTrees,1);
VarMaxMatrix = repmat(ProblemParams.VarMax,AlgorithmParams.NumOfTrees,1);
Trees = (VarMaxMatrix - VarMinMatrix) .* rand(size(VarMinMatrix)) + VarMinMatrix;
end



