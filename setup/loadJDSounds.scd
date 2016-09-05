//LOADS SOUNDS FILES INTO BUFFERS
(
var clips;
var loops;
var dir, loopDir;

if(b.notNil,{
		b.do{|sub|
				sub.do{|soundFolder|
					soundFolder.do{|sound|
						sound.free;
					};
				};
			};
	});

b=();

dir = "~/JDSounds/clip".standardizePath;
// CLIPS
clips = PathName(dir);
clips.entries.do{|folder|
	var folderName;
	folderName = folder.folderName.asSymbol;
	b[folderName] = ();
	// folderName.postln;

	folder.entries.do{|soundFolder|
		var soundFolderName;
		soundFolderName = soundFolder.folderName.asSymbol;
		b[folderName][soundFolderName] = Dictionary();	

		soundFolder.entries.do{|sound|
			var buf;
			var soundName = sound.fileNameWithoutExtension.asSymbol;
			buf = Buffer.read(s,sound.fullPath);
			// buf.postln;
			// b[folderName][soundFolderName] = b[folderName][soundFolderName].add(buf);
			b[folderName][soundFolderName].add(soundName -> buf);

		}
	}
};

b[\drums] = {
	{|...drum|
		var arr;
		drum.postln;
		arr = drum.collect{|d|
			b.kit[d.asSymbol]
		};
		arr.flatten;
	}
};

// LOOPS
b[\loops] = ();
loopDir = "~/JDSounds/loop".standardizePath;
loops = PathName(loopDir);

loops.entries.do{|tempo|
	tempo.entries.do{|folder|
		var folderName = folder.folderName.asSymbol;

		b.loops[folderName] = Dictionary();

		folder.entries.do{|sound|
			var soundName = sound.fileNameWithoutExtension.asSymbol;
			var loopFile;
			var loopPath;
			loopPath = sound.fullPath;
			loopFile = Buffer.read(s,loopPath);
			loopFile.postln;
			loopFile.tempo = tempo.folderName.asFloat;
			loopFile.tempo.postln;
			b.loops[folderName].add(soundName -> loopFile);
		}

	}
}

)