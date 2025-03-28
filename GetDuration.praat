form Get audio file duration
    word Sound_file_extension .wav
    sentence Output_file_name output.csv
    comment Press OK to choose a directory.
endform

procedure getFiles: .dir$, .ext$
    .obj = Create Strings as file list: "files", .dir$ + "/*" + .ext$
    .length = Get number of strings

    for .i to .length
        .fname$ = Get string: .i
        .files$ [.i] = .dir$ + "/" + .fname$

    endfor

    removeObject: .obj

endproc

directory$ = chooseDirectory$: "Choose a directory:"
outfile$ = directory$ + "\" +output_file_name$
writeFileLine: outfile$, "file,duration"
@getFiles: directory$, sound_file_extension$

for i to getFiles.length
    soundfile = Read from file: getFiles.files$ [i]
    filename$ = selected$("Sound")
    filename_full$ = filename$ + sound_file_extension$
    duration = Get total duration
    duration_mili = duration * 1000
    appendFileLine: outfile$, "'filename_full$', 'duration_mili'"

    select all
    Remove
endfor