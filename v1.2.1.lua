--Debug.Clear();
--Debug.ShowWindow(true);

	--This is a table(array) which contains all the alphabets in random order.
	tbl_SHAR = {"l","y","f","q","o","s","c","b","x","r","d","j","n","e","p","w","a","h","v","k","m","i","u","z","t","g"};
	tbl_SHARCAPS = {"L","Y","F","Q","O","S","C","B","X","R","D","J","N","E","P","W","A","H","V","K","M","I","U","Z","T","G"};
	
	--Contains Symbols
	tbl_SYMBOLS = {"`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+","\\","|","[","]","{","}",";",":","'","\"",",","<",".",">","/","?"};
	
	--These tables contain all the alphabets in correct order.
	tbl_ALPHA = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
	tbl_ALPHACAPS = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
	
	--This one contains numbers in correct order
	tbl_NUM = {"0","1","2","3","4","5","6","7","8","9"};
	
	--Contains All typable characters (for Password usage)
	--tbl_PASS = {" ","0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+","\\","|","[","]","{","}",";",":","'","\"",",","<",".",">","/","?"};
	tbl_PASS = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};

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

function posInPass(str)	--Calculate position in the passtable
	for f = 1, 36 do	
		if str == tbl_PASS[f] then				
			return f;	
		end	
	end
	return 0
end

--#######################################################################

function Ravi_Encrypt(string)
	
	strlen = String.Length(string);			--The length of string
	
	encText = "";							--The encrypted text currently "Nothing"
	
	pass = Crypto.MD5DigestFromString(Input.GetText("inPass"));	--The Passsword	
		
	passLen = #pass;						--Length of Password
	passCntr = 0; 							--Pass Counter
		
	for e = 1, strlen do
	
		posInAlpha = 0;						--The position of the character in lowercase alphabets	
		posInAlphaCaps = 0;					--The position of the character in uppercase alphabets
		posInString = 0;					--The position of the character in the clear text
				
		nChar = String.Mid(string, e, 1);	--Get the string character by character
		
		if passCntr <= passLen then passCntr = passCntr + 1 end	--DO NOT convert these conditions to 
		if passCntr > passLen then passCntr = 1 end			--	if..else.. or the results would vary.	
				
		nPass = String.Mid(pass, passCntr, 1);	--Get the password character by character

--[[	
	Updated versions of	posInAlpha & posInAlphaCaps
	Previously I used to traverse the table	till the argument matched with a table value; 
				the index used to be the position
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
		So, basically he is the father of this algorithm without knowing anything about it
		
		What we do here is: Add all the positions(Alpha, Caps, String & Pass) so as a result 
		we get different encrypted text which varies with the string and the password used.
		
		for e.g.
		The encrypted complement of 'a' in strings 'Shadab' and 'Ravi' will vary as in the first
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
		
		sumOfPos = sumOfPos % 26		--Handle Characters greater than 26
		if sumOfPos == 0 then sumOfPos = 26 end

--Debug.Print("NewSumOfPos = "..sumOfPos.."\r\n");
			
		if IsUpper(nChar) then								--Uppercase Chars
			encText = encText..tbl_SHARCAPS[sumOfPos];					
		elseif IsLower(nChar) then							--Lowercase chars
			encText = encText..tbl_SHAR[sumOfPos];			
		elseif IsNumber(nChar) and CheckBox.GetChecked("encNum") then		--Numbers	
			local num = String.ToNumber(nChar);
			encNum = num + posInString;
			
			while encNum > 9 do								--Make the number unary i.e 26 becomes 8 (2+6)			
				local encNumStr = tostring(encNum);
				encNum = 0;
				
				for o = 1, String.Length(encNumStr) do
					num = String.ToNumber(String.Mid(encNumStr, o, 1));
					encNum = encNum + num;								
				end				
			end			
			encText = encText..encNum;
		else
			encText = encText..nChar;						--Un-Encrypted Text		
		end	
		
--Debug.Print("encText = "..encText.."\r\n\r\n");	
		
	end --End of FOR LOOP
	
	return encText;
	
end --End Of FUNCTION

-----------------------------------------------

function Ravi_Decrypt(string)

	local strlen = String.Length(string);	
	
	local decText = "";
	
	local pass = Crypto.MD5DigestFromString(Input.GetText("inPass"));	--The Passsword	
	
	passLen = String.Length(pass);			--Length of Password
	passCntr = 0; 							--Pass Counter						
		
	for p = 1, strlen do
	
		posInShar = 0;
		posInSharCaps = 0;
		posInString = 0;
				
		nChar = String.Mid(string, p, 1);
		
		if passCntr <= passLen then passCntr = passCntr + 1 end	--DO NOT convert these conditions to 
		if passCntr > passLen then passCntr = 1 end			--	if..else.. or the results would vary.

		nPass = String.Mid(pass, passCntr, 1);
				
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

		while diffOfPos <= 0 do
			diffOfPos = diffOfPos + 26;			
		end
		
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
		elseif IsNumber(nChar) and CheckBox.GetChecked("encNum") then		--Numbers	
			local num = String.ToNumber(nChar);
			decNum = num - posInString;			
			while decNum <= 0 do decNum = decNum + 9 end
						
			decText = decText..decNum;			
		else
			decText = decText..nChar;								--Un-Encrypted Text
		end
				
--Debug.Print("decText = "..decText.."\r\n\r\n");
		
	end
	
	return decText;
	
end

--################################################################################################################

if Task == "Encrypt" then

	local clearText = Input.GetText("clearText");
	--Encrypt the text and Set it to the textbox
	if CheckBox.GetChecked("strRev") then
		Input.SetText("clearText", string.reverse(clearText));
		Input.SetText("encText", Ravi_Encrypt(string.reverse(clearText)));
	else
		Input.SetText("encText", Ravi_Encrypt(clearText));
	end
	
elseif Task == "Decrypt" then

	local clearText = Input.GetText("clearText");	
	--Decrypt the text and Set it to the textbox
	if CheckBox.GetChecked("strRev") then
		Input.SetText("encText", string.reverse(Ravi_Decrypt(clearText)));
	else
		Input.SetText("encText", Ravi_Decrypt(clearText));
	end
end