import std.string;
import std.stdio;
import std.random;
import std.conv;
import std.file;

string cipherprocess(){
    // s string gets cipher chars appended to it and then it gets succ'd(+1'd) to generate random characters
    // to add to the cipher
    string s;
    // vowels and symbols to add and loop through
    char[8] vowelsym = ['a','e','I','o','U','y','%',';'];
    writeln("welcome to DRandomCipher by Markmental");
    writeln("This is a secure password generator that uses random characters\n");
    writeln("This program is free software released under:");
    writeln("GNU General Public License v3.0");
    writeln("https://www.gnu.org/licenses/gpl-3.0.en.html\n");
    writeln("Please enter a string to seed the cipher(3 characters is usually sufficient)");
    string ogtxt = chomp(readln());
    // dup duplicates the ogtext string array into a traditional C-style char array
    // im making it a flexible array & letting the garbage collector deal with it's memory allocation
    char[] txtarray = ogtxt.dup;
    writeln(txtarray);
    // random chars i chose that can be appended to s string and then the cipher
    char[18] cipherchars = ['+','|','g','&','(','#','~',':','a','3', 't', 'b', '4','X','_','1','2', '*'];
    auto rnd = Random(unpredictableSeed);
    // rng to choose a character
    auto charchoice = uniform(0, 17, rnd);
    // the main cipher variable
    string cipher;
	
    // nested rng: adds cipherchars to the s string increments from 1 to 50 times and then adds another succ'd by 1
    // this happens in a range from 1 to 2 times for each character in vowels
    for (int i = 0; i < uniform(1, 2, rnd); i++){
        s~=to!string(cipherchars[charchoice] + uniform(1, 50, rnd));
        cipher~=s;

        foreach(char c; vowelsym){
            string newchar = to!string(c);
            newchar~=cipherchars[uniform(0, 17, rnd)];
            cipher~=newchar;
        }
    }
	
    // for each char in the txtarray increment its value by number between
    // 1 and 50
    foreach (char c; txtarray){
        string cs = to!string(c + uniform(1, 50, rnd));
        cipher~=cs;
    }

    writeln(cipher);
    cipher~="\n";
    return cipher;
}

void main(){
	string cipher = cipherprocess();
	writeln("Would you like to save this password?(y/n)");
	string response = chomp(readln());

	if (response == "y" || response == "Y"){
		writeln("Enter a name for the text file (omit file extension)");
		string filename = chomp(readln());
		filename~=".txt";
		std.file.write(filename, cipher);
		writeln(filename, " was written to successfully");
	}
}
