Debug.Clear();

--[[
	AMS doesn't has any String.IsUpper() function so i wrote mine :)
]]--

function IsUpper(char)
	tbl_ALPHACAPS = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};

	for m = 1, 26 do
		if char == tbl_ALPHACAPS[m] then				
			return true;								
		end			
	end
	return false;
end

--[[
	It also doesn't has any IsNumber() but I do :)
]]--

function IsNumber(char)
	if (type(String.ToNumber(char)) == "number") then
		return true
	else
		return false
	end
end

--[[
	Neither it has any String.Reverse() function so i had to write mine :}
]]--

Debug.ShowWindow(true);

function Reverse(str)
	
	local len = String.Length(str);
	strrev = ""
	
	for n = len, 1, -1 do		
		lChar = String.Mid(str,n,1)
		strrev = strrev..lChar
Debug.Print("Reversed String:"..strrev.."\r\n")		
	end
Debug.Print("\r\n")

	return strrev;	
end

--#######################################################################

function Ravi_Encrypt(string)

--[[
	This is a table which contains all the alphabets in random order.
	
	Sandeep, one of my friends helped me out with this.
]]--

	tbl_RAVI = {"l","y","f","q","o","s","c","b","x","r","d","j","n","e","p","w","a","h","v","k","m","i","u","z","t","g"};
	
	--This table contains all the alphabets in correct order.
	tbl_ALPHA = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
	
	local strlen = String.Length(string);	--The length of string
	
	local encText = "";						--The encrypted text currently "Nothing"
		
	for i = 1, strlen do
	
		posInAlpha = 0;							--The position of the character in the alphabets	
		posInString = 0;						--The position of the character in the clear text
				
		nChar = String.Mid(string, i, 1);	--This helps to get the string character by character
		
Debug.Print("nChar = "..nChar.."\r\n");
				
		for j = 1, 26 do	
			if nChar == tbl_ALPHA[j] then				
				posInAlpha = j;				--The actual position in alphabets
				break;		
			end	
		end
		
Debug.Print("posInAlpha = "..posInAlpha.."\r\n");
		
		posInString = i;					--The actual position in the passed string		
		
Debug.Print("posInString = "..posInString.."\r\n");		
		
--[[		
		This is the main feature of this encryption algorithm, An idea of my friend RAVI KUMAR. 
		So, basically he is the father of this algorithm although he knows nothing about algorithms.
		
		What we do here is add both the positions so as a result we get different encrypted text which varies with the strings.
		
		For e.g.
		The encrypted complement of 'a' in strings 'Shadab' and 'Ravi' will vary as in the first string 'a' occurs at 
		3rd & 5th position while in second string it occurs at 2nd position.
]]--
		sumOfPos = posInAlpha + posInString;
		
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
			
		if IsUpper(nChar) then							--If the character is Uppercase, So should be it's encrypted form
			encText = encText..String.Upper(tbl_RAVI[sumOfPos]);
		elseif nChar == " " then
			encText = encText.." "						--If the character is a 'space' then concat a 'space'				
		elseif IsNumber(nChar) then
		
			local num = String.ToNumber(nChar);
			
			encNum = num + posInString;
			
			while encNum > 9 do
				
				local encNumStr = tostring(encNum);
				local sLen = String.Length(encNumStr);
				
				encNum = 0;
				
				for e = 1, sLen do
					num = String.ToNumber( String.Mid(encNumStr, e, 1) );
					encNum = encNum + num;								
				end				
			end
			
			encText = encText..encNum;	
		elseif posInAlpha == 0 then
			encText = encText..nChar					--If it is some other character then concat it as it is.	
		else
			encText = encText..tbl_RAVI[sumOfPos];		--Concat the encrypted complement of the character.			
		end	
		
Debug.Print("encText = "..encText.."\r\n\r\n");	
		
	end 
	
	return encText;
	
end --End Of FUNCTION

---------------------------------------------------------------------------------------------

local clearText = Input.GetText("clearText")

--Encrypt the text and Set it to the textbox
if CheckBox.GetChecked("strRev") then
	Input.SetText( "encText", Ravi_Encrypt( Reverse(clearText) ) );
else
	Input.SetText( "encText", Ravi_Encrypt(clearText) );
end