# Assembly Language Projects
Welcome to the Assembly Language Projects repository! This collection contains various projects implemented in assembly language, showcasing the versatility and power of low-level programming. Below is a detailed overview of each project included in this repository.

# Projects Overview

## Caesar Cipher

### **Description:** 

Implements the Caesar cipher encryption technique, which shifts each character in the plaintext by a fixed number of positions in the alphabet.

### **Features:**
  - Encrypts and decrypts text.
  - User-defined shift value.

### **Detailed Explanation:**
  - **Encryption:** Each letter in the plaintext is shifted by a fixed number of positions defined by the user. For example, with a shift of 3, 'A' becomes 'D', 'B' becomes 'E', and so on. Wrapping is handled so that 'Z' wraps around to 'C'.
  - **Decryption:** The reverse process of encryption, shifting characters back by the same number of positions to retrieve the original text.

### **Usage:** 

Run the program and provide the plaintext and shift value as inputs.

---

## Keylogger

### **Description:** 

A simple keylogger that records keystrokes to a file.

### **Features:**
  - Logs all keystrokes.
  - Saves logs to a specified file.

### **Detailed Explanation:**
  - **Keystroke Logging:** Captures each keystroke made by the user and writes it to a log file. This can be used for monitoring user input or debugging.

### **Usage:** 

Run the program and it will start logging keystrokes automatically. The log file can be specified or set to a default location.

---

## Random Password Generator

### **Description:** 

Generates random passwords of a user-defined length.

### **Features:**
  - Allows customization of password length.
  - Generates secure random passwords.

### **Detailed Explanation:**
  - **Password Generation:** Uses a random number generator to create a sequence of characters, including uppercase letters, lowercase letters, digits, and special characters, ensuring a strong and unpredictable password.

### **Usage:**

Run the program and specify the desired password length. The generated password will be displayed or saved to a file.

---

## Character Classifier

### **Description:** 

Classifies characters into categories such as alphabets, digits, and special characters.

### **Features:**

  - Identifies and counts different types of characters.

### **Detailed Explanation:**
  - **Classification:** Reads input text and categorizes each character. Alphabets are counted separately for uppercase and lowercase, digits are counted, and any other characters are classified as special characters.

### **Usage:** 

Run the program and input the text to be classified. The output will show the counts of each type of character.

---

## Palindrome Checker

### **Description:** 

Checks if a given string is a palindrome.

### **Features:**

  - Determines if the input string reads the same forwards and backwards.

### **Detailed Explanation:**

  - **Palindrome Checking:** Compares characters from the beginning and end of the string, moving towards the center. If all characters match, the string is a palindrome.

### **Usage:** 

Run the program and input the string to be checked. The output will indicate whether the string is a palindrome.

---

## Letter, Word, and Sentence Counter

### **Description:** 

Counts the number of words, letters, and sentences in a given text file.

### **Features:**
  - Reads text from a file and provides a detailed count.

### **Detailed Explanation:**
  - **Counting:** Reads the content of a text file and counts the number of words, letters, and sentences. Words are typically defined by spaces or punctuation, letters by alphabetical characters, and sentences by periods, exclamation marks, or question marks.

### **Usage:** 

Run the program and provide the path to the text file. The output will show the counts of words, letters, and sentences.

---

## Encryption Scheme

### **Description:**

Performs simple encryption and decryption on an input string using a custom key and substitution method.

### **Features:**
  - **Input Handling:** Prompts for user input.
  - **Encryption:** Transforms input using a key.
  - **Decryption:** Reverts the encrypted text to plaintext.
  - **Display:** Shows plaintext, encrypted, and decrypted text

### **Detailed Explanation:**

  - **Setup and Loop Initialization**: Saves the current state of registers (`pushad`), sets the loop counter (`ecx`) to the size of the buffer (`bufSize`), and initializes indices for the buffer (`esi`) and key (`edi`).
  
  - **Encryption Loop**: For each byte in the buffer, it performs a series of operations involving the `KEY` and `alphabets` arrays to transform the byte, incrementing both `esi` and `edi` indices. Resets `edi` to 0 after processing 6 characters.
  
  - **Cleanup and Return**: Restores the saved state of registers (`popad`) and returns from the procedure.

---
