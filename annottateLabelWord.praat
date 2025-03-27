# User inputs
form Replace "sound" labels with words from a word list
   word Directory_name: /Users/patricia/Desktop/Internship/Wavs/Words/
   word TextGrid_name: Xirong_Words_Mono_2_denoised
   word wordDirec_name: /Users/patricia/Desktop/Internship/Wavs/
   word wordFile_name: wordlist
   positive Tier_number: 1
endform

# Initialize parameters
numberOfWords = 0
wordList$ = ""

# Read the TextGrid file
Read from file... 'Directory_name$''TextGrid_name$'.TextGrid
textGridID = selected("TextGrid")

# Get the number of intervals in the specified tier
select textGridID
intvl_length = Get number of intervals: tier_number

# Check that the number of words matches the number of "sound" labels
soundCount = 0
for i from 1 to intvl_length
    label$ = Get label of interval: tier_number, i
    if label$ = "sound"
        soundCount = soundCount + 1
    endif
endfor

# Get the number of labels with "sound"
writeInfo: "The number of sound is", soundCount

# Creat a list of words
wordFilePath$ = "'wordDirec_name$''wordFile_name$'.txt"
if not fileReadable(wordFilePath$)
    writeInfo: "Cannot read file: " + wordFilePath$ + ". Please check if the file exists and you have read permissions."
endif

Read Strings from raw text file... 'wordFilePath$'
numberOfWords = Get number of strings

for i to numberOfWords
    wordList$[i] = Get string... i
endfor

# Print the words to verify
for i to numberOfWords
    appendInfoLine: wordList$[i]
endfor

# Replace "sound" labels with words from the word list
select textGridID
wordIndex = 1
for i from 1 to intvl_length
    label$ = Get label of interval: tier_number, i
    if label$ = "sound"
		if wordIndex <= numberOfWords
        		# Get the word from the word list
        		word$ = wordList$[wordIndex]
			
			# Replace the "sound" label with the corresponding word
        		Set interval text: tier_number, i, word$
        		wordIndex = wordIndex + 1
		else
			printline("Warning: Ran out of words in the word list.")
			exit
		endif
	endif
endfor
        

# Save the modified TextGrid
Write to text file... 'Directory_name$''TextGrid_name$'_modified.TextGrid
printline TextGrid successfully updated with word labels and saved as 'TextGrid_name$'_modified.TextGrid