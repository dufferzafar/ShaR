function Ravi_Encrypt(string, strength)

	tbl_RAVI = {"l","y","f","q","o","s","c","b","x","r","d","j","n","e","p","w","a","h","v","k","m","i","u","z","t","g"};
	
	tbl_ALPHA = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
	
	local string = String.Lower(string);	--We will handle uppercase chars later
	local strlen = String.Length(string);	--The length of string
	
	local encText = "";						--The encrypted text currently "Nothing"
		
	posInAlpha = 0;							--The position of the character in the alphabets
	
	posInString = 0;						--The position of the character in the clear text
	

	for i = 1, strlen do
	
		nChar = String.Mid(string, i, 1);	--This helps to get the string character by character
				
		for j = 1, 26 do	
			if nChar == tbl_ALPHA[j] then				
				posInAlpha = j;				--The actual position in alphabets
				break;		
			end	
		end
		
		posInString = i;					--The actual position in the passed string
		
		if posInAlpha == 0 or posInString == 0 then		--Both of them shouldn't be zer0
			Dialog.Message("Error Occured", "An internal error occured in the algorithm.\n\nPress OK to abort.", MB_OK, MB_ICONSTOP, MB_DEFBUTTON1);
			break;
		end
		
--[[		
		This is the main feature of this encryption algorithm
		This idea is of my friend RAVI KUMAR. 
		So, basically he is the father of this algorithm although he knows nothing about algorithms.
		
		What we do here is add both the positions so as a result we get different encrypted text which varies with the strings.
		
		For e.g.
		The encrypted complement of 'a' in strings 'Shadab' and 'Ravi' will vary as in the first string 'a' occurs at 
		3rd & 5th position while in second string it occurs at 2nd position.
]]--
		sumOfPos = posInAlpha + posInString;
		
--[[
		So that all the characters are handled.
		
		If this is ommited you won't be able to encrypt 'z' as sumOfPos will then be 27 and there is no value corresponding
		to it in tble_RAVI.		
]]--		
		if sumOfPos > 26 then
			sumOfPos = sumOfPos - 26;
		end
		
		encText = encText..tbl_RAVI[sumOfPos];
		
	end 
	
	return encText;
	
end --End Of FUNCTION

---------------------------------------------------------------------------------------------

local clearText = Input.GetText("clearText")

--Encrypt the text and Set it to the textbox
Input.SetText("encText", Ravi_Encrypt(clearText, 0));