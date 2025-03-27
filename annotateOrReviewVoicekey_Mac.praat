form Analyze annotateOrReview
	word homeDir /Users/patricia/Desktop/Internship/Data_Processing/BEH/
	positive start  1
	integer stop_(0_=_all_files)   0
endform

Create Strings as file list... fileList  'homeDir$'/*.wav
n = Get number of strings

if stop < 1
	stop = n
endif

for i from 'start' to 'stop'
	select Strings fileList
	a$ = Get string... 'i'
	Read from file... 'homeDir$'/'a$'
	b$ = selected$("Sound",1)
	textGrid$ = b$ + ".TextGrid"
	textGridFile$ = homeDir$ + "/"+ textGrid$
	if fileReadable(textGridFile$)
		Read from file... 'textGridFile$'
		plus Sound 'b$'
		Edit
		pause check this already annotated file
	else
		To TextGrid (silences)...  60 0  -15 0.1 0.1 silent sound
		plus Sound 'b$'
		Edit
		pause annotate this file
	endif
	select TextGrid 'b$'
	Write to text file... 'textGridFile$'
	onset = Get start point... 1 2
	printline 'a$'	'onset'
	select all
	minus Strings fileList
	Remove
endfor