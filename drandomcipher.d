import std.string;
import std.stdio;
import std.random;
import std.file;


string cipherprocess(){
    string s;
    char[5] vowels = ['a','e','i','o','u'];
    writeln("welcome to DRandomCipher by Markmental");
    writeln("This is a secure string generator that uses random characters");
    writeln("This program is free software released under:");
    writeln("GNU General Public License v3.0");
    writeln("Please enter a string to seed the cipher");
    string ogtxt = chomp(readln());
    char[] txtarray = ogtxt.dup;
    char[13] cipherchars = ['r','t','5','6','(','%','~','n','a','3', '9', 'b', '4'];
    auto rnd = Random(unpredictableSeed);
    auto charchoice = uniform(0, 12, rnd);
    string cipher;

    for (int i = 0; i < uniform(5, 20, rnd); i++){
        s~= cipherchars[charchoice];
        cipher~=succ(s);
        cipher~= cipherchars[charchoice];
    }

    foreach (char c; txtarray){
        s ~= vowels[uniform(0 , 4)];
        cipher~=succ(s);
    }

    writeln(cipher);
    return cipher;
}


void main(){
    string cipher = cipherprocess();

    writeln("Would you like to save this cipher?(y/n)");
    string sc = chomp(readln());

    if (sc == "y" || sc == "Y"){
	std.file.write("cipher.txt", cipher);
	auto file = read("cipher.txt");
	if (file != cipher){
		writeln("file was not written successfully");
	}
	else{
		writeln("File written successfully");
	}
    }
}
