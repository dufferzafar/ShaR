--Debug.Clear();
--Debug.ShowWindow(true);

--This is a table(array) which contains all the alphabets in random order.
tbl_SHAR = {"l","y","f","q","o","s","c","b","x","r","d","j","n","e","p","w","a","h","v","k","m","i","u","z","t","g"};
tbl_SHARCAPS = {"L","Y","F","Q","O","S","C","B","X","R","D","J","N","E","P","W","A","H","V","K","M","I","U","Z","T","G"};

--These tables contain all the alphabets in correct order.
tbl_ALPHA = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
tbl_ALPHACAPS = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};

--Contains Symbols
--tbl_SYMBOLS = {"`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+","\\","|","[","]","{","}",";",":","'","\"",",","<",".",">","/","?"};

--Contains All typable characters (for Password usage)
--tbl_PASS = {" ","0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+","\\","|","[","]","{","}",";",":","'","\"",",","<",".",">","/","?"};

--########################## Helper Functions ###########################
--[[
	Updated versions of IsUpper(), IsLower(), IsNumber()
	Previously I used to traverse appropriate table till the argument matched with any of the table values.
	eg. 	
	for x = 1, 26 do
		if passed_Arg == tbl_ALPHA[x] then				
			return true;								
		end			
	end
	return false;
]]--
function IsUpper(char)
	local asc = string.byte(char);	
	if asc >= 65 and asc <= 90 then	return true 
	else return false end
end

function IsLower(char)
	local asc = string.byte(char);	
	if asc >= 97 and asc <= 122 then return true 
	else return false end
end

function IsNumber(char)	
	if string.find(char, "%d") ~= nil then return true
	else return false end
end

function posInPass(char)	--Calculate position in the passtable
	if string.find(char, "%d") ~= nil then 
		return tonumber(char)
	else
		local asc = string.byte(char)
		if not asc then
			return 0
		elseif asc >= 65 and asc <= 90 then 
			return (asc - 64)
		elseif asc >= 97 and asc <= 122 then 
			return (asc - 96)
		end
	end
	
	return 0
end

--#######################################################################

function Shar_Encrypt(pText, pass, encNum)
	
	--Initialize Variables
	if not pass then pass = "" end
	if not encNum then encNum = false end
	
	encText = "";							--The encrypted text, currently "Nothing"
	pTextLen = #pText;						--The length of plain text

	passLen = #pass;						--Length of Password
	passCntr = 0; 							--Pass Counter

	for e = 1, pTextLen do

		posInAlpha = 0;						--Position of the character in Lowercase alphabets	
		posInAlphaCaps = 0;					--Position in Uppercase alphabets
		posInString = 0;					--Position in Plain Text

		nChar = string.sub(pText, e, e);	--Get the string character by character
		
		if passCntr <= passLen then passCntr = passCntr + 1 end	--DO NOT convert these conditions to 
		if passCntr > passLen then passCntr = 1 end				--if..else.. or the results would vary

		nPass = string.sub(pass, passCntr, passCntr);	--Get the password character by character

--[[
	Updated versions of	posInAlpha & posInAlphaCaps
	Previously I used to traverse the table	till the argument matched with a table value;
				the index used to be the position.
	eg.
		for m = 1, 26 do
			if nChar == tbl_ALPHA[m] then
				posInAlpha = m;
				break;
			end
		end
]]--		
		local asc = string.byte(nChar);		--The actual position in the alphabets
		if asc >= 65 and asc <= 90 then posInAlphaCaps = asc - 64 else posInAlphaCaps = 0 end
		if asc >= 97 and asc <= 122 then posInAlpha = asc - 96 else posInAlpha = 0 end	
		
		posInString = e;					--The actual position in the passed string		

--[[	
		This is the main feature of this cipher, An idea of my friend RAVI KUMAR. 
		
		What we do here is: Add all the positions(Alpha, Caps, String & Pass) so as a result 
		we get different encrypted text which varies with the string and the password used.
		
		for e.g.
		The cipher text of 'a' in strings 'Shadab' and 'Ravi' will vary as in the first
		string 'a' occurs at 3rd & 5th position while in second string it occurs at 2nd position.
		
		Either one of posInAlpha or posInAlphaCaps will always be zero.
]]--
		sumOfPos = posInAlpha + posInAlphaCaps + posInString + posInPass(nPass);

--Debug.Print("nChar = "..nChar.."\r\n");		
--Debug.Print("nPass = "..nPass.."\r\n");	
--Debug.Print("posInPass = "..posInPass(nPass).."\r\n");	
--Debug.Print("posInAlpha = "..posInAlpha.."\r\n");	
--Debug.Print("posInAlphaCaps = "..posInAlphaCaps.."\r\n");	
--Debug.Print("posInString = "..posInString.."\r\n");		
--Debug.Print("sumOfPos = "..sumOfPos.."\r\n");
		
		sumOfPos = sumOfPos % 26		--Handle Characters greater than 26, (mod 26)
		if sumOfPos == 0 then sumOfPos = 26 end

--Debug.Print("NewSumOfPos = "..sumOfPos.."\r\n");
			
		if IsUpper(nChar) then								--Uppercase Chars
			encText = encText..tbl_SHARCAPS[sumOfPos];					
		elseif IsLower(nChar) then							--Lowercase chars
			encText = encText..tbl_SHAR[sumOfPos];			
		elseif IsNumber(nChar) and encNum then		--Numbers	
			local num = tonumber(nChar);
			eNum = num + posInString;
			
			while eNum > 9 do								--Make the number unary i.e 26 becomes 8 (2+6)			
				local eNumStr = tostring(eNum);
				eNum = 0;
				
				for o = 1, string.len(eNumStr) do
					num = tonumber(string.sub(eNumStr, o, o));
					eNum = eNum + num;					
				end				
			end			
			encText = encText..eNum;
		else
			encText = encText..nChar;						--Un-Encrypted Text		
		end	
		
--Debug.Print("encText = "..encText.."\r\n\r\n");	
		
	end --End of FOR LOOP
	
	return encText;
	
end --End Of FUNCTION

-----------------------------------------------

function Shar_Decrypt(cText, pass, decNum)

	--Initialize Variables
	if not pass then pass = "" end
	if not encNum then encNum = false end
	
	local cTextLen = string.len(cText);	
	local decText = "";

	passLen = string.len(pass);				--Length of Password
	passCntr = 0; 							--Pass Counter						
		
	for p = 1, cTextLen do
	
		posInShar = 0;
		posInSharCaps = 0;
		posInString = 0;
				
		nChar = string.sub(cText, p, p);
		
		if passCntr <= passLen then passCntr = passCntr + 1 end	--DO NOT convert these conditions to 
		if passCntr > passLen then passCntr = 1 end				--	if..else.. or the results would vary.

		nPass = string.sub(pass, passCntr, passCntr);
				
		for q = 1, 26 do
			if nChar == tbl_SHAR[q] then	
				posInShar = q;
				break;
			end
		end

		for r = 1, 26 do
			if nChar == tbl_SHARCAPS[r] then			
				posInSharCaps = r;
				break;
			end
		end
		
		posInString = p;
				
		diffOfPos = posInShar + posInSharCaps - posInString - posInPass(nPass);

		while diffOfPos <= 0 do diffOfPos = diffOfPos + 26 end
		
--Debug.Print("nChar = "..nChar.."\r\n");
--Debug.Print("nPass = "..nPass.."\r\n");
--Debug.Print("posInPass = "..posInPass(nPass).."\r\n");
--Debug.Print("posInShar = "..posInShar.."\r\n");
--Debug.Print("posInSharCaps = "..posInSharCaps.."\r\n");
--Debug.Print("posInString = "..posInString.."\r\n");
--Debug.Print("diffOfPos = "..diffOfPos.."\r\n");
--Debug.Print("NewDiffOfPos = "..diffOfPos.."\r\n");

		if IsUpper(nChar) then										--UpperCase Chars
			decText = decText..tbl_ALPHACAPS[diffOfPos];
		elseif IsLower(nChar) then									--LowerCase Chars
			decText = decText..tbl_ALPHA[diffOfPos];
		elseif IsNumber(nChar) and decNum then		--Numbers	
			local num = tonumber(nChar);
			dNum = num - posInString;			
			while dNum <= 0 do dNum = dNum + 9 end						
			decText = decText..dNum;	
		else
			decText = decText..nChar;							--Un-Encrypted Text
		end
				
--Debug.Print("decText = "..decText.."\r\n\r\n");
		
	end
	
	return decText;	
end

--################################################################################################################

--file = io.open("Test.txt", "r")
--file2 = io.open("Test-ShaR-ed.txt", "w")

--file2:write(Shar_Encrypt(file:read("*all"), "ShadabZafar", false))

--file:close(); file2:close();

print(Shar_Encrypt("Bomb Phodna Hai Jama Masjid Pe", "ujmko", false))
print(Shar_Decrypt(Shar_Encrypt("Bomb Phodna Hai Jama Masjid Pe", "ujmko", false), "ujmko", false))
