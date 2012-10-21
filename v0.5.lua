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


function Ravi_Encrypt(string, strength)

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
		
		for j = 1, 26 do	
			if nChar == tbl_ALPHA[j] then				
				posInAlpha = j;				--The actual position in alphabets
				break;		
			end	
		end
		
		posInString = i;					--The actual position in the passed string		
		
--[[		
		This is the main feature of this encryption algorithm, An idea of my friend RAVI KUMAR. 
		So, basically he is the father of this algorithm although he knows nothing about algorithms.
		
		What we do here is add both the positions so as a result we get different encrypted text which varies with the strings.
		
		For e.g.
		The encrypted complement of 'a' in strings 'Shadab' and 'Ravi' will vary as in the first string 'a' occurs at 
		3rd & 5th position while in second string it occurs at 2nd position.
]]--
		sumOfPos = posInAlpha + posInString;
		
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
		elseif posInAlpha == 0 then
			encText = encText..nChar					--If the character is not an alphabet then concat it as it is.		
		else
			encText = encText..tbl_RAVI[sumOfPos];		--Concat the encrypted complement of the character.			
		end		
		
	end 
	
	return encText;
	
end --End Of FUNCTION

---------------------------------------------------------------------------------------------

local clearText = Input.GetText("clearText")

--Encrypt the text and Set it to the textbox
Input.SetText("encText", Ravi_Encrypt(clearText, 0));