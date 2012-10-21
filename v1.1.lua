--Debug.Clear();
--Debug.ShowWindow(true);

--[[
	this is a table which contains all the alphabets in random order.
	
	Sandeep, one of my friends helped me out with this.
]]--
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
	tbl_PASS = {" ","0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+","\\","|","[","]","{","}",";",":","'","\"",",","<",".",">","/","?"};

--AMS doesn't has any String.IsUpper() or String.IsLower() function so i wrote mine :)
function IsUpper(char)
	for a = 1, 26 do
		if char == tbl_ALPHACAPS[a] then				
			return true;								
		end			
	end
	return false;
end

function IsLower(char)
	for b = 1, 26 do
		if char == tbl_ALPHA[b] then				
			return true;								
		end			
	end
	return false;
end

--It also doesn't has any IsNumber() but I do :)
function IsNumber(char)
	for c = 1, 10 do
		if char == tbl_NUM[c] then				
			return true;								
		end			
	end
	return false;
	
	--type(String.ToNumber(char) == "number") seems to do the same job but it sucks when a " " or "\n" is passed
	
end

--Neither it has any String.Reverse() function so i had to write mine :}

function Reverse(str)	
	local len = String.Length(str);
	strrev = ""
	
	for d = len, 1, -1 do		
		lChar = String.Mid(str,d,1)

		strrev = strrev..lChar
	end
	return strrev;	
end

--########################## Helper Functions ###########################

function posInPass(str)
	for f = 1, 95 do	
		if str == tbl_PASS[f] then				
			return f;	
		end	
	end
	return 0
end

--#######################################################################

function Ravi_Encrypt(string)
	
	local strlen = String.Length(string);	--The length of string
	
	local encText = "";						--The encrypted text currently "Nothing"
	
	local pass = Input.GetText("inPass");	--The Passsword	
	
	passLen = String.Length(pass);			--Length of Password
	cp = 0; 								--Pass Counter
		
	for e = 1, strlen do
	
		posInAlpha = 0;						--The position of the character in lowercase alphabets	
		posInAlphaCaps = 0;					--The position of the character in uppercase alphabets
		posInString = 0;					--The position of the character in the clear text
				
		nChar = String.Mid(string, e, 1);	--Get the string character by character
		
		if cp <= passLen then				--DO NOT convert these conditions to if..else.. or the results would vary.	
			cp = cp + 1	;
		end	
				
		if cp > passLen then	
			cp = 1;
		end
		
		nPass = String.Mid(pass, cp, 1);
		
--Debug.Print("nChar = "..nChar.."\r\n");		
--Debug.Print("nPass = "..nPass.."\r\n");	
--Debug.Print("posInPass = "..posInPass(nPass).."\r\n");		
			
		for m = 1, 26 do	
			if nChar == tbl_ALPHA[m] then				
				posInAlpha = m;				--The actual position in alphabets
				break;		
			end	
		end
		
--Debug.Print("posInAlpha = "..posInAlpha.."\r\n");

		for n = 1, 26 do	
			if nChar == tbl_ALPHACAPS[n] then				
				posInAlphaCaps = n;
				break;		
			end	
		end
		
--Debug.Print("posInAlphaCaps = "..posInAlphaCaps.."\r\n");
		
		posInString = e;					--The actual position in the passed string		
		
--Debug.Print("posInString = "..posInString.."\r\n");
		
		
--[[		
		this is the main feature of this cipher, An idea of my friend RAVI KUMAR. 
		So, basically he is the father of this algorithm although he knows nothing about algorithms.
		
		What we do here is add both the positions so as a result we get different encrypted text which varies with the strings.
		
		for e.g.
		The encrypted complement of 'a' in strings 'Shadab' and 'Ravi' will vary as in the first string 'a' occurs at 
		3rd & 5th position while in second string it occurs at 2nd position.
		
		Either one of posInAlpha or posInAlphaCaps will be zero.
]]--
		sumOfPos = posInAlpha + posInAlphaCaps + posInString + posInPass(nPass);
		
--Debug.Print("sumOfPos = "..sumOfPos.."\r\n");
		
--[[
		Handle Characters greater than 26
		
		if this is ommited you won't be able to encrypt 'z' as sumOfPos will then be 27 and there is no value corresponding
		to it in tbl_SHAR.		
		
		Here, a while loop is a better option than an if condition.
]]--	
		while sumOfPos > 26 do
			sumOfPos = sumOfPos - 26;		
		end
		
--Debug.Print("NewSumOfPos = "..sumOfPos.."\r\n");
			
		if nChar == " " then								--Space
			encText = encText.." ";
		elseif posInAlpha == 0 and posInAlphaCaps == 0 and IsNumber(nChar) == false then	--Non-Alphanumeric.
			encText = encText..nChar					
		elseif IsUpper(nChar) then							--Uppercase Chars
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
					num = String.ToNumber( String.Mid(encNumStr, o, 1) );
					encNum = encNum + num;								
				end				
			end			
			encText = encText..encNum;
		else
			encText = encText..nChar;						--Un-Encrypted Text		
		end	
		
--Debug.Print("encText = "..encText.."\r\n\r\n");	
		
	end 
	
	return encText;
	
end --End Of FUNCTION

-----------------------------------------------

function Ravi_Decrypt(string)

	local strlen = String.Length(string);	
	
	local decText = "";
	
	local pass = Input.GetText("inPass");	--The Passsword	
	
	passLen = String.Length(pass);			--Length of Password
	cp = 0; 								--Pass Counter						
		
	for p = 1, strlen do
	
		posInShar = 0;
		posInSharCaps = 0;
		posInString = 0;
				
		nChar = String.Mid(string, p, 1);
		
		if cp <= passLen then				--DO NOT convert these conditions to if..else.. or the results would vary.	
			cp = cp + 1	;
		end	
				
		if cp > passLen then	
			cp = 1;
		end
		
		nPass = String.Mid(pass, cp, 1);
		
--Debug.Print("nChar = "..nChar.."\r\n");		
--Debug.Print("nPass = "..nPass.."\r\n");	
--Debug.Print("posInPass = "..posInPass(nPass).."\r\n");	
				
		for q = 1, 26 do	
			if nChar == tbl_SHAR[q] then				
				posInShar = q;
				break;		
			end	
		end
		
--Debug.Print("posInShar = "..posInShar.."\r\n");

		for r = 1, 26 do	
			if nChar == tbl_SHARCAPS[r] then				
				posInSharCaps = r;
				break;		
			end	
		end
		
--Debug.Print("posInSharCaps = "..posInSharCaps.."\r\n");	
		
		posInString = p;
		
--Debug.Print("posInString = "..posInString.."\r\n");	
		
		diffOfPos = posInShar + posInSharCaps - posInString - posInPass(nPass);
				
--Debug.Print("diffOfPos = "..diffOfPos.."\r\n");
		
		while diffOfPos < 0 or diffOfPos == 0 do
			diffOfPos = diffOfPos + 26;			
		end
		
--Debug.Print("NewDiffOfPos = "..diffOfPos.."\r\n");
		
		if nChar == " " then
			decText = decText.." ";
		elseif posInShar == 0 and posInSharCaps == 0 and IsNumber(nChar) == false then		--Non-Alphanumeric
			decText = decText..nChar	
		elseif IsUpper(nChar) then									--UpperCase Chars
			decText = decText..tbl_ALPHACAPS[diffOfPos];
		elseif IsLower(nChar) then									--LowerCase Chars
			decText = decText..tbl_ALPHA[diffOfPos];
		elseif IsNumber(nChar) and CheckBox.GetChecked("encNum") then		--Numbers	
			local num = String.ToNumber(nChar);
			decNum = num - posInString;
			
			while decNum < 0 or decNum == 0 do				
				decNum = decNum + 9			
			end			
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
		Input.SetText("clearText", Reverse(clearText));
		Input.SetText("encText", Ravi_Encrypt(Reverse(clearText)));
	else
		Input.SetText("encText", Ravi_Encrypt(clearText));
	end
	
elseif Task == "Decrypt" then

	local clearText = Input.GetText("clearText");
	
	--Decrypt the text and Set it to the textbox
	if CheckBox.GetChecked("strRev") then
		Input.SetText("encText", Reverse(Ravi_Decrypt(clearText)));
	else
		Input.SetText("encText", Ravi_Decrypt(clearText));
	end
end