Debug.Clear();
Debug.ShowWindow(true);

--[[
	This is a table which contains all the alphabets in random order.
	
	Sandeep, one of my friends helped me out with this.
]]--
	tbl_RAVI = {"l","y","f","q","o","s","c","b","x","r","d","j","n","e","p","w","a","h","v","k","m","i","u","z","t","g"};
	tbl_RAVICAPS = {"L","Y","F","Q","O","S","C","B","X","R","D","J","N","E","P","W","A","H","V","K","M","I","U","Z","T","G"};
	
	--These table contains all the alphabets in correct order.
	tbl_ALPHA = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
	tbl_ALPHACAPS = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};


--AMS doesn't has any String.IsUpper() or String.IsLower() function so i wrote mine :)
function IsUpper(char)
	for i = 1, 26 do
		if char == tbl_ALPHACAPS[i] then				
			return true;								
		end			
	end
	return false;
end

function IsLower(char)
	for j = 1, 26 do
		if char == tbl_ALPHA[j] then				
			return true;								
		end			
	end
	return false;
end

--It also doesn't has any IsNumber() but I do :)
function IsNumber(char)
	if (type(String.ToNumber(char)) == "number") then
		return true
	else
		return false
	end
end

--Neither it has any String.Reverse() function so i had to write mine :}

function Reverse(str)
	
	local len = String.Length(str);
	strrev = ""
	
	for k = len, 1, -1 do		
		lChar = String.Mid(str,k,1)

		strrev = strrev..lChar
		
Debug.Print("Reversed String = "..strrev.."\r\n")		
	end
Debug.Print("\r\n")

	return strrev;	
end

--#######################################################################

function Ravi_Encrypt(string)
	
	local strlen = String.Length(string);	--The length of string
	
	local encText = "";						--The encrypted text currently "Nothing"
		
	for l = 1, strlen do
	
		posInAlpha = 0;						--The position of the character in lowercase alphabets	
		posInAlphaCaps = 0;					--The position of the character in uppercase alphabets
		posInString = 0;					--The position of the character in the clear text
				
		nChar = String.Mid(string, l, 1);	--This helps to get the string character by character
		
Debug.Print("nChar = "..nChar.."\r\n");
				
		for m = 1, 26 do	
			if nChar == tbl_ALPHA[m] then				
				posInAlpha = m;				--The actual position in alphabets
				break;		
			end	
		end
		
Debug.Print("posInAlpha = "..posInAlpha.."\r\n");

		for n = 1, 26 do	
			if nChar == tbl_ALPHACAPS[n] then				
				posInAlphaCaps = n;
				break;		
			end	
		end
		
Debug.Print("posInAlphaCaps = "..posInAlphaCaps.."\r\n");
		
		posInString = l;					--The actual position in the passed string		
		
Debug.Print("posInString = "..posInString.."\r\n");		
		
--[[		
		This is the main feature of this encryption algorithm, An idea of my friend RAVI KUMAR. 
		So, basically he is the father of this algorithm although he knows nothing about algorithms.
		
		What we do here is add both the positions so as a result we get different encrypted text which varies with the strings.
		
		For e.g.
		The encrypted complement of 'a' in strings 'Shadab' and 'Ravi' will vary as in the first string 'a' occurs at 
		3rd & 5th position while in second string it occurs at 2nd position.
		
		Either one of posInAlpha or posInAlphaCaps will be zero.
]]--
		sumOfPos = posInAlpha + posInString + posInAlphaCaps;
		
Debug.Print("sumOfPos = "..sumOfPos.."\r\n");
		
--[[
		Handle Characters greater than 26
		
		If this is ommited you won't be able to encrypt 'z' as sumOfPos will then be 27 and there is no value corresponding
		to it in tbl_RAVI.		
		
		Here, a while loop is a better option than an if condition.
]]--	
		while sumOfPos > 26 do
			sumOfPos = sumOfPos - 26;		
		end
		
Debug.Print("NewSumOfPos = "..sumOfPos.."\r\n");
			
		if nChar == " " then
			encText = encText.." ";
		elseif IsUpper(nChar) then							--If the character is Uppercase, So should be it's encrypted form
			encText = encText..tbl_RAVICAPS[sumOfPos];					
		elseif IsLower(nChar) then
			encText = encText..tbl_RAVI[sumOfPos];			
		elseif IsNumber(nChar) and CheckBox.GetChecked("encNum") then		
			local num = String.ToNumber(nChar);
			encNum = num + posInString;
			
			while encNum > 9 do				
				local encNumStr = tostring(encNum);
				encNum = 0;
				
				for o = 1, String.Length(encNumStr) do
					num = String.ToNumber( String.Mid(encNumStr, o, 1) );
					encNum = encNum + num;								
				end				
			end			
			encText = encText..encNum;				
		elseif posInAlpha == 0 and posInAlphaCaps == 0 then
			encText = encText..nChar					--If it is some other character then concat it as it is.	
		else
			encText = encText..tbl_RAVI[sumOfPos];		--Concat the encrypted complement of any other character.			
		end	
		
Debug.Print("encText = "..encText.."\r\n\r\n");	
		
	end 
	
	return encText;
	
end --End Of FUNCTION

-----------------------------------------------

function Ravi_Decrypt(string)

	local strlen = String.Length(string);	
	
	local decText = "";						
		
	for p = 1, strlen do
	
		posInRavi = 0;
		posInRaviCaps = 0;
		posInString = 0;
				
		nChar = String.Mid(string, p, 1);
		
Debug.Print("nChar = "..nChar.."\r\n");
				
		for q = 1, 26 do	
			if nChar == tbl_RAVI[q] then				
				posInRavi = q;
				break;		
			end	
		end
		
Debug.Print("posInRavi = "..posInRavi.."\r\n");

		for r = 1, 26 do	
			if nChar == tbl_RAVICAPS[r] then				
				posInRaviCaps = r;
				break;		
			end	
		end
		
Debug.Print("posInRaviCaps = "..posInRaviCaps.."\r\n");	
		
		posInString = p;
		
Debug.Print("posInString = "..posInString.."\r\n");	
		
		diffOfPos = posInRavi + posInRaviCaps - posInString
				
Debug.Print("diffOfPos = "..diffOfPos.."\r\n");
		
		if diffOfPos < 0 then
			diffOfPos = -1 * diffOfPos		
		elseif diffOfPos == 0 then
			diffOfPos = diffOfPos + 26;			
		end
		
		if nChar == " " then
			decText = decText.." ";
		elseif IsUpper(nChar) then									--UpperCase Chars
			decText = decText..tbl_ALPHACAPS[diffOfPos];
		elseif IsLower(nChar) then									--LowerCase Chars
			decText = decText..tbl_ALPHA[diffOfPos];				
		elseif posInRavi == 0 and posInRaviCaps == 0 then			--All Other Chars
			encText = decText..nChar				
		else
			decText = decText..tbl_ALPHA[diffOfPos];
		end
		
Debug.Print("decText = "..decText.."\r\n\r\n");
		
	end
	
	return decText;
	
end

--################################################################################################################

if Task == "Encrypt" then

	local clearText = Input.GetText("clearText");
	
	--Encrypt the text and Set it to the textbox
	if CheckBox.GetChecked("strRev") then
		Input.SetText( "clearText", Reverse(clearText) );
		Input.SetText( "encText", Ravi_Encrypt( Reverse(clearText) ) );
	else
		Input.SetText( "encText", Ravi_Encrypt(clearText) );
	end
	
else

	local clearText = Input.GetText("clearText");
	
	Input.SetText( "encText", Ravi_Decrypt(clearText) );

end