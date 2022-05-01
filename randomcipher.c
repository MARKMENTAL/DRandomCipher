#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>


const char* cipher_process(){
	int char_lower = 0, char_upper = 21;
	int vowel_lower = 0, vowel_upper = 7;
	int pw_length;
	char pw_length_temp;
	char vowelsym[8] ={'a','e','I','o','U','y','%',';'};
	char cipherchars[22] ={'+','|','g','&','(','#','~',':','a','3', 't', 'b', '4','X','_','1','2', '*'};
	// specifying test as static so the compiler can free memory knowing it will only be used in this function 
	static char pw_string[30] = "Password Generated: ";
	srand(time(0));
	printf("\nChoose a length for the password:\n1:Short\n2:Medium\n3:Long\n");
	pw_length_temp = getchar();
	if (pw_length_temp == '1'){
		pw_length = 5;
	}
	else if (pw_length_temp == '2'){
		pw_length = 15;
	}
	else if (pw_length_temp == '3'){
		pw_length = 25;
	}
	else {
		printf("Invalid input, exiting\n");
		abort();
	}

	// divide password length by 2 since two chars are appended to pw_string for each run through of the loop
	for (int i =0; i <= pw_length/2; i+=1){
		// generates number between 0 and 21 (cipherchar array selection range)
		int rand_num_char = (rand() % (char_upper - char_lower));
		// generates number between 0 and 7 (vowel array selection range)
		int rand_num_vowel = (rand() % (vowel_upper - vowel_lower));
		// uses generated numbers to select a random char from each array relative to the array selection range
		char rand_char = cipherchars[rand_num_char];
		char rand_vowel = vowelsym[rand_num_vowel];
		// using strncat to concatenate the random chars and vowels to the password string
		strncat(pw_string, &rand_char, 1);
		strncat(pw_string, &rand_vowel, 1);
	}

	strcat(pw_string, "\n");

	return pw_string;
}

void save_pw(const char* password){
	FILE *file_write;
	char* text_file;
	printf("Enter a name for a text file to save your password to.\nYou can also type a full path to save to a specific directory.\nExample: '/home/your_user/Documents/your_file.txt' or simply 'your_file.txt'\n");
	scanf("%s", text_file);
	file_write = fopen(text_file, "w");
	fprintf(file_write, "%s", password);
	fclose(file_write);
	printf("\n%s written to successfully\n", text_file);
	

}

int main(){
	printf("Hello and welcome to RandomCipher: The C Version\nThis program is designed for Linux/Unix-Like OSes\nIt is designed to randomly generate and save secure passwords.\n\n");
	//password string is constant, it can't be changed after running the cipher process
	const char* password = cipher_process();
	printf("%s\n", password);
	save_pw(password);
	return 0;
}
