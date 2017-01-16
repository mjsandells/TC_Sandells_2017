% Calculates mean brightness temperature over entire season for each microwave model (year 2)
load dmrtsortedresults_y2.mat
load memlssortedresults_y2.mat
load hutsortedresults_y2.mat

% 19v
dmrt = dmrtsortedresults(:,6);
memls = memlssortedresults(:,6);
hut = hutsortedresults(:,6);
disp "19V"
disp "dmrt:"
nanmean(dmrt)

disp "hut:"
nanmean(hut)

disp "memls:"
nanmean(memls)

% 19h
dmrt = dmrtsortedresults(:,11);
memls = memlssortedresults(:,11);
hut = hutsortedresults(:,11);
disp "19H"
disp "dmrt:"
nanmean(dmrt)

disp "hut:"
nanmean(hut)

disp "memls:"
nanmean(memls)

% 37v
dmrt = dmrtsortedresults(:,16);
memls = memlssortedresults(:,16);
hut = hutsortedresults(:,16);
disp "37V"
disp "dmrt:"
nanmean(dmrt)

disp "hut:"
nanmean(hut)

disp "memls:"
nanmean(memls)

% 37h
dmrt = dmrtsortedresults(:,21);
memls = memlssortedresults(:,21);
hut = hutsortedresults(:,21);
disp "37H"
disp "dmrt:"
nanmean(dmrt)

disp "hut:"
nanmean(hut)

disp "memls:"
nanmean(memls)