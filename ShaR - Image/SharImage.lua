--Encrypt
function sharImage(inFile, outFile, sharFile)

	local fileA = io.open(inFile, "rb");
	local fileB = io.open(outFile, "wb");
	local fileC = io.open(sharFile, "rb");
	local hintText = "\n\n\n\n\n\n\\n\n\nn\n\n\n\n Hey Hammad This is Where the new image Begins --- This line is a hint ---- if its not there you'l have a tough time cracking the nut coz the two files would be joined	\n\n\n\n\n\n\n\n\n\n"
	--Create OutFile
	fileB:write(fileC:read("*a"));
	fileB:write(hintText)
	fileB:write(fileA:read("*a"));
	
	--fileSizes help to verify process
	local fileSizeA = fileA:seek("cur");
	local fileSizeB = fileB:seek("cur");
	local fileSizeC = fileC:seek("cur");
	
	fileA:close(); fileB:close(); fileC:close()
	
	--Check if everything happened correctly
	if fileSizeA + fileSizeC + #hintText == fileSizeB then return 0, fileSizeC + #hintText
	else return -1 end
	
end

--Decrypt
function unSharImage(inFile, outFile, sharFileBytes)
	
	if inFile == outFile then
		outFile = outFile.."-temp"
	end	
	
	local fileA = io.open(inFile, "rb")
	local fileB = io.open(outFile, "wb")
	
	--Create outFile
	fileA:seek("set", sharFileBytes)	
	fileB:write(fileA:read("*a"))

	--Get file sizes
	local fileSizeA = fileA:seek("end")
	local fileSizeB = fileB:seek("cur")
	
	if inFile == outFile then
		os.remove(inFile)
		os.rename(outFile, inFile)
	end
	
	--Check if everything happened correctly
	if fileSizeB + sharFileBytes == fileSizeA then return 0
	else return -1 end
	
end

--fileSize of MidFing.png = 60235

print(sharImage("Untitled.png", "Main(ShaR).png", "MidFing.png"))
-- print(unSharImage("Main(ShaR).png", "Main(UnShaR).png", 60235))
-- print(unSharImage("Main(ShaR).png", "Main(UnShaR).png", 60373))

