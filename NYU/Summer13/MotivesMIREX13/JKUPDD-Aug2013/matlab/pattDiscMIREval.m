% Copyright Tom Collins 13/8/2013

% Calculating evaluation metrics for example pattern discovery algorithm
% output.

% The following paths will need correcting for a specific file system: the
% location of the JKU Patterns Development Database.
dataRoot = fullfile('~', 'NYU', 'Summer13', 'MotivesMIREX13',...
  'JKUPDD-Aug2013', 'groundTruth');
% The location of the function pattAllOccAll2struct and this script
% (pattDiscExampleEval).
projectRoot = fullfile('~', 'NYU', 'Summer13', 'MotivesMIREX13',...
  'JKUPDD-Aug2013', 'matlab');
% The location of the functions estPrecRecMat, occPrecRecMat, threeLayerF1,
% precisionRecallTrans, and scoreMatrix. These can be distributed across
% different folders,...
coreRoot = fullfile('~', 'NYU', 'Summer13', 'MotivesMIREX13',...
  'JKUPDD-Aug2013', 'matlab');
% ...as long as each folder is added here.
addpath(fullfile(coreRoot, 'analysis'),...
  fullfile(coreRoot, 'patternMatching'));
% Add the functions specific to this project.
addpath(fullfile(projectRoot))
% Location to save results.
metricResultsPath = fullfile(projectRoot, 'results');

% Define the names of the algorithms that are to be evaluated.
algOut = ... %{fullfile(projectRoot, 'pattDiscOut', 'nf1')} ,...
  ...%fullfile(projectRoot, 'pattDiscOut', 'nf2')} ,...
  ...%fullfile(projectRoot, 'pattDiscOut', 'nf3'),...
  {fullfile(projectRoot, 'pattDiscOut', 'nf1')};

% Define the names of the pieces forming the ground truth.
pieces = {fullfile(dataRoot, 'bachBWV889Fg'),...
  fullfile(dataRoot, 'beethovenOp2No1Mvt3'),...
  fullfile(dataRoot, 'chopinOp24No4'),...
  fullfile(dataRoot, 'gibbonsSilverSwan1612'),...
  fullfile(dataRoot, 'mozartK282Mvt2')};
labels = {'bach_wtc2f20', 'beet_sonata01-3', 'chop_mazurka24-4',...
  'gbns_silverswan' 'mzrt_sonata04-2'};
polyAnn = {'bruhn' 'barlowAndMorgensternRevised' 'sectionalRepetitions'...
  'schoenberg' 'tomCollins'};
monoAnn = {'bruhn' 'barlowAndMorgenstern' 'barlowAndMorgensternRevised'...
  'sectionalRepetitions' 'schoenberg' 'tomCollins'};
compIDs = {'bach_', 'beet_', 'chop_', 'gbns_', 'mzrt_'};

% Specify version of the task and some parameters for the evaluation
% metrics.
taskVer = 'monophonic';
projectionIdx = [1 2];
similarThresh = [.75 .5];
similarFunc = 'cardinality score';


% Load runtimes and fifth return times (FRT) as nalgOut x npiece matrices.
% The matrices are defined here, and the times are loaded from text files
% below.
nalgOut = size(algOut, 2);
npiece = size(pieces, 2);
RT = zeros(nalgOut, npiece);
FRT = zeros(nalgOut, npiece);

% Load ground truths for each piece into the variable called GT.
if strcmp(taskVer, 'polyphonic')
  annotations = polyAnn;
else
  annotations = monoAnn;
end
% Variable to hold patterns for all pieces.
GT = cell(1, npiece);
for ipiece = 1:npiece
  % Variable to hold patterns for current piece.
  T = struct([]);
  pattj = 1; % Increment to create T.
  % Iterate over different annotations.
  currAnn = fullfile(pieces{ipiece}, taskVer, 'repeatedPatterns');
  contents = dir(currAnn);
  ncont = size(contents, 1);
  for icont = 1:ncont
    currAnnName = contents(icont).name;
    if ismember(currAnnName, annotations)
      % Include the patterns from this annotation.
      annCont = dir(fullfile(currAnn, currAnnName));
      pattn = size(annCont, 1);
      for patti = 1:pattn
        pattName = annCont(patti).name;
        % Check that it is a proper name, e.g., A, B, or some letters.
        if isletter(pattName(1)) &&...
            isempty(regexp(pattName, '.txt', 'once'))
          % Add the pattern.
          pattPath = fullfile(currAnn, currAnnName, pattName, 'csv');
          fname = dir(fullfile(pattPath, '*.csv'));
          fname = fname.name;
          %fprintf('Pattern %s\n', fname);
          P = csvread(fullfile(pattPath, fname));
          T(pattj).annotation = currAnnName;
          T(pattj).patternName = pattName;
          T(pattj).patternNotProjected = P;
          T(pattj).pattern = unique(P(:, projectionIdx), 'rows');
          % Add the occurrences.
          occPath = fullfile(currAnn, currAnnName, pattName,...
            'occurrences', 'csv');
          occCont = dir(occPath);
          occn = size(occCont, 1);
          occurrences = cell(1, occn);
          occj = 1; % Increment to populate occurrences.
          for occi = 1:occn
            currOcc = occCont(occi).name;
            if ~isempty(regexp(currOcc, 'occ', 'once')) &&...
                ~isempty(regexp(currOcc, '.csv', 'once'))
              occurrences{occj} = csvread(fullfile(occPath, currOcc));
              occj = occj + 1;
            end
          end
          occurrences = occurrences(1:occj - 1);
          T(pattj).occurrences = occurrences;
          pattj = pattj + 1;
        end
      end
    end
  end
  GT{ipiece} = struct;
  GT{ipiece}.k = size(projectionIdx, 2);
  GT{ipiece}.details = T;
end

% Comparing the algorithms' output to the ground truths, and save to a
% results file.
fprintf('Writing results in %s\n', fullfile(metricResultsPath, 'results.txt'));
fid = fopen(fullfile(metricResultsPath, 'results.txt'), 'w');
% Iterate over the algorithms.
for ialgOut = 1:nalgOut
  [~, algStub, ~] = fileparts(algOut{ialgOut});
  fprintf(fid, 'Algorithm %d, %s\n', ialgOut, algStub);
  fprintf('Algorithm %d\n', ialgOut);
  fprintf(fid, ['P_est, R_est, F1_est, '...
    'P_occ(c=.75), R_occ(c=.75), F_1occ(c=.75), '...
    'P_3, R_3, TLF_1, '...
    'FFTP_est, FFP, '...
    'P_occ(c=.5), R_occ(c=.5), F_1occ(c=.5), '...
    'P, R, F_1\n']);
  % Find the results for this algorithm.
  outCont = dir(fullfile(algOut{ialgOut}, '*.txt'));
  nOut = size(outCont, 1);
  % Store all results
  allResults = zeros(npiece, 21); % npicie x 21 metrics
  % Iterate over the pieces.
  for ipiece = 1:npiece
    if (ipiece ~= 4)
        continue;
    end
    nParam = 1;
    % Find relevant member of outCont for algorithm output.
    rel_idx = [];
    iOut = 1;
    while iOut <= nOut
      if ~isempty(regexp(outCont(iOut).name, labels{ipiece}, 'once')) &&...
        isempty(regexp(outCont(iOut).name, 'runtime', 'once'))
        rel_idx = iOut;
        iOut = nOut;
      end
      iOut = iOut + 1;
    end
    % Find relevant member of outCont for runtime.
    run_idx = [];
    iOut = 1;
    while iOut <= nOut
      if ~isempty(regexp(outCont(iOut).name, labels{ipiece}, 'once')) &&...
        ~isempty(regexp(outCont(iOut).name, 'runtime', 'once'))
        run_idx = iOut;
        iOut = nOut;
      end
      iOut = iOut + 1;
    end
    if ~isempty(rel_idx)
      fprintf(fid, '%s-%s\n', labels{ipiece}, taskVer);
      fprintf('Piece %d: %s\n', ipiece, labels{ipiece});
      fprintf('Ground truth path: %s\n', fullfile(algOut{ialgOut},...
        outCont(rel_idx).name))
      % Load the results.
      Q = pattAllOccAll2struct(fullfile(algOut{ialgOut},...
        outCont(rel_idx).name));
      % Load the runtime and fifth return time if available.
      if ~isempty(run_idx)
        fid_run = fopen(fullfile(algOut{ialgOut}, outCont(run_idx).name));
        A = textscan(fid_run, '%s %f');
        fclose(fid_run);
        RT(ialgOut, ipiece) = A{2}(1);
        FRT(ialgOut, ipiece) = A{2}(2);
      end
      % Give the number of ground truth patterns and number of algorithm-
      % output patterns.
%       fprintf(fid, '%d, %d, ', size(GT{ipiece}.details, 2), size(Q, 2));
%       allResults(ipiece, nParam) = size(GT{ipiece}.details, 2);
%       allResults(ipiece, nParam + 1) = size(Q, 2);
%       nParam = nParam + 2;
      
      % Calculate and print establishment precision and recall.
      [p_est, r_est, S] = estPrecRecMat(GT{ipiece}, Q, similarFunc);
      if p_est == 0 && r_est == 0
        f1_est = 0;
      else
        f1_est = 2*p_est*r_est/(p_est + r_est);
      end
      fprintf(fid, '%6.5f, %6.5f, %6.5f, ', p_est, r_est, f1_est);
      allResults(ipiece, nParam) = p_est;
      allResults(ipiece, nParam + 1) = r_est;
      allResults(ipiece, nParam + 2) = f1_est;
      nParam = nParam + 3;
      
      % Calculate and print occurrence precision and recall for c = .75.
      [p_occ, r_occ, ~, ~] = occPrecRecMat(GT{ipiece}, Q,...
        similarThresh(1), similarFunc);
      if p_occ == 0 && r_occ == 0
        f1_occ = 0;
      else
        f1_occ = 2*p_occ*r_occ/(p_occ + r_occ);
      end
      fprintf(fid, '%6.5f, %6.5f, %6.5f, ', p_occ, r_occ, f1_occ);
      allResults(ipiece, nParam) = p_occ;
      allResults(ipiece, nParam + 1) = r_occ;
      allResults(ipiece, nParam + 2) = f1_occ;
      nParam = nParam + 3;
      
      % Calculate and print three-layer precision and recall.
      [p3, r3, TLF] = threeLayerF1({GT{ipiece}.details(:).occurrences},...
        {Q.occurrences});
      fprintf(fid, '%6.5f, %6.5f, %6.5f, ', p3, r3, TLF);
      allResults(ipiece, nParam) = p3;
      allResults(ipiece, nParam + 1) = r3;
      allResults(ipiece, nParam + 2) = TLF;
      nParam = nParam + 3;
      
      % Include runtime and FRT, and calculate FFTP_est and FFP. If there
      % are fewer than five patterns returned, use the variable idx5 to
      % avoid this causing an error.
      idx5 = min(5, size(Q, 2));
      [~, FFTP_est, ~] = estPrecRecMat(GT{ipiece}, Q(1:idx5), similarFunc);
      Q1st5 = {Q.occurrences};
      Q1st5 = Q1st5(1:idx5);
      [FFP, ~, ~] = threeLayerF1({GT{ipiece}.details(:).occurrences},...
        Q1st5);
      fprintf(fid, '%6.5f, %6.5f, ', FFTP_est, FFP);
      allResults(ipiece, nParam) = FFTP_est;
      allResults(ipiece, nParam + 1) = FFP;
      nParam = nParam + 2;
      
      % Calculate and print occurrence precision and recall for c = .5.
      [p_occ, r_occ, ~, ~] = occPrecRecMat(GT{ipiece}, Q,...
        similarThresh(2), similarFunc);
      if p_occ == 0 && r_occ == 0
        f1_occ = 0;
      else
        f1_occ = 2*p_occ*r_occ/(p_occ + r_occ);
      end
      fprintf(fid, '%6.5f, %6.5f, %6.5f, ', p_occ, r_occ, f1_occ);
      allResults(ipiece, nParam) = p_occ;
      allResults(ipiece, nParam + 1) = r_occ;
      allResults(ipiece, nParam + 2) = f1_occ;
      nParam = nParam + 3;
      
      % Calculate standard precision, recall, and F1.
      [p r ~] = precisionRecallTrans(Q, GT{ipiece});
      if p == 0 && r == 0
        f1 = 0;
      else
        f1 = 2*p*r/(p + r);
      end
      fprintf(fid, '%6.5f, %6.5f, %6.5f\n\n', p, r, f1);
      allResults(ipiece, nParam) = p;
      allResults(ipiece, nParam + 1) = r;
      allResults(ipiece, nParam + 2) = f1;
      nParam = nParam + 3;
    end
  end
  % Save the mean of all results to the file
%   meanResults = mean(allResults);
%   for param_indx = 1:21
%       if param_indx == 21
%         fprintf(fid, '%6.5f\n\n', meanResults(param_indx)); 
%       else
%         fprintf(fid, '%6.5f, ', meanResults(param_indx));
%       end
%   end
end
