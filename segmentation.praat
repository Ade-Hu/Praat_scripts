#Cuts up a large sound file into smaller chunks using an existing tier on an associated TextGrid file.
#The object name is the sound file name. The TextGrid name is the name of the Praat TextGrid file which
#is time-aligned with the sound file. The Renamed file prefix is a string that the user can add to all
#extracted intervals for the particular sound file, e.g. speaker name, session info, etc. The tier number
#reflects the tier containing the string which will be used for the main file name. The assumption of this
#script is that you have a tier containing only ascii characters which you wish to use as the filename of
#the smaller file.

#This script is useful for either experimental purposes (e.g. cutting up tokens into smaller files which are more
#manageable) or for corpus/fieldwork linguistic purposes (e.g. you export an ELAN file to Praat and then extract
#words of a particular type). 

#Copyright Christian DiCanio, SUNY Buffalo, 2016, 2020.

form Extract smaller files from large file
   sentence Directory_name: /Users/patricia/Desktop/Internship/Wavs/Work/
   sentence Objects_name: Xirong_Words_Mono_2_denoised
   sentence TextGrid_name: Xirong_Words_Mono_2_denoised_modified
   sentence Renamed_file_prefix: 
   positive Tier_number: 1
endform

Read from file... 'Directory_name$''Objects_name$'.wav
soundID = selected("Sound")

Read from file... 'Directory_name$''TextGrid_name$'.TextGrid
textGridID = selected("TextGrid")
select 'textGridID'
intvl_length = Get number of intervals: tier_number

for i from 1 to intvl_length
	lab$ = Get label of interval: tier_number, i
	time = Get starting point: tier_number, i
	index$ = string$(time)

	if lab$ = ""
		#do nothing
	else 
		start = Get starting point: tier_number, i
		end = Get end point: tier_number, i
		select 'textGridID'
		tg_chunk = Extract part: start, end, "no"
		select 'soundID'
		Extract part... start end rectangular 1 no
		Write to WAV file... 'Directory_name$'/'Renamed_file_prefix$''lab$'.wav
		select 'tg_chunk'
		Save as text file... 'Directory_name$'/'Renamed_file_prefix$''lab$'.TextGrid
	endif
	select 'textGridID'
endfor
select all
Remove
