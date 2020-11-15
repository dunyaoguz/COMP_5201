The Code You Were Given
_______________________


/*
                                            // this is the 
  l.d   f2,4(r1)                            // program to be  
  l.d   f4,8(r3)                            // simulated;
  mul.d f6,f2,f4                            // no pipelining
  add.d f8,f4,f6
  bne   r5,r5,target
  s.d   f6,8(r3)
  s.d   f8,4(r5)
  bne   r7,r9,target
  l.d   f2,8(r7)
  s.d   f2,8(r7)
target:

*/

#include <iostream>  // for std::cout

int main () {
  // all submissions must contain this prelude, or equivalent

  // register file
  int Reg[10];
  Reg[1] = 105; Reg[3] = 203; Reg[5] = 301; // r-register values
  Reg[7] = 148; Reg[9] = 156;

  // main memory
  int  Mem[500];
  char XMem[] = "llmabssbls";               // ten opcodes, and
  Mem[0] = 124; Mem[1] = 348; Mem[2] = 246; // their ten argument
  Mem[3] = 468; Mem[4] = 550; Mem[5] = 368; // lists; object code
  Mem[6] = 584; Mem[7] = 790; Mem[8] = 728; // for ten instructions
  Mem[9] = 728;

  Mem[109] = 19; Mem[156] = 25;             // assorted data memory
  Mem[211] = 43;                            // values

  bool branch;                              // for bne results
  std:: cout << "\n";                       // blank line

  // loop over instructions; pretend next instruction is at PC + 1
  for( int PC = 0; PC < 10; PC++ ) {

    // f-box
    char head = XMem[PC];                   // these are shared variables
    int  tail = Mem[PC];                    // that the d-box will use
    std::cout << "f: Fetched instruction: " << head << "|" << tail << ".\n";

    // d-box
    char opc = head;                        // decode instruction
    int arg3 = tail % 10;                   // into its opcode and
    tail = tail / 10;                       // its three arguments
    int arg2 = tail % 10;                   // inst = {opc,arg1,...}
    tail = tail / 10;
    int arg1 = tail;
    std::cout << "d: Set opc to '" << opc << "'.\n";
    // 'opc' is the next datapath "shared variable" to be initialized;
    // 'arg1', 'arg2', 'arg3' are d-box local variables

    // all code, or equivalent, above this line is mandatory

    int D_Out1, D_Out2, dreg, sval;         // more shared variables
    switch( opc ) {                         // You may imitate this style.
      case 'a':
      case 'm':
        D_Out1 = Reg[arg1];                 // localize reg. operand and latch
        std::cout << "d: Set D_Out1 to " << D_Out1 << ".\n";
        D_Out2 = Reg[arg2];                 // localize reg. operand and latch
        std::cout << "d: Set D_Out2 to " << D_Out2 << ".\n";
        dreg = arg3;                        // latch dest. register designator
        std::cout << "d: Set dreg to f" << dreg << ".\n";
        break;
        ...                                 // case statement not finished
    }
    ...                                     // program not finished
 
1) There are ten registers in the register file.  While I pretend that 
some are f-registers and some are r-registers, in the simulation they 
are all simply integer registers, namely, Reg : 'array'[0..9] 'of' integer;

2) The object code for the test program has already been generated and
stored in memory for you.  Recall the instruction formats from Lecture 3.

3) Each of the five boxes generates data/control for subsequent boxes.
In the simulation, this translates to: Each of the five boxes initializes
shared variables that are read by subsequent boxes.  Each time a useful
result is generated, both write the simulation code to generate that result,
and indicate having done so with a print statement.  To avoid chaos, stick
with the variable names appearing in the template.  Example: The global d-box
variables are 'opc', 'D_Out1', 'D_Out2', 'dreg', and 'sval', while the
local variables are 'arg1', 'arg2', and 'arg3'.  Note that updating the
register file, updating the memory, or making a branch decision, is a useful
result, and deserves a print statement.  In the simulation, we transmit both
data and control by writing certain shared variables, many of which are
mentioned above.

4) 'bne' has special emulation rules.  If the branch is not taken, continue
with the next instruction.  If the branch is taken, skip all remaining
instructions, and terminate the program normally.  The 'for' loop needs to
be informed about this decision.

5) Although the template code uses case statements, this is not required.
It is, however, easier to code and to read.  

6) In the code, register designators are decimal digits.  For example, f2
is really just 2 (the print statements tell white lies!).

7) Full output for the first instruction is shown to give you some idea
of what kind of output is expected.

8) Submissions must contain all source code and all output (as an appended
comment) in a _single_ machine-readable ASCII text file.  A formal
submission requires electronic transmission of the text file to Moodle.
Call it "Programming Assignment 3".

9) If a box does nothing, print "<box name>: Did nothing."

---
 
    // x-box                                // more of the template     
    int X_Out;
    switch( opc ) {
    ...
    }

    // m-box
    int M_Out;
    switch( opc ) {
    ...
    }

    // w-box
    switch( opc ){
    ...
    }

    std::cout << "\n";
    ...
  }                                         // end 'for' loop
  ...
}
/*

f: Fetched instruction: l|124.
d: Set opc to 'l'.
d: Set D_Out1 to 105.
d: Set D_Out2 to 4.
d: Set dreg to f2.
x: Set X_Out to 109.
m: Set M_Out to 19.
w: Set f2 to 19.

...

*/

---end of assignment text---

Hints for Assignment 3
______________________

1. Instruction Formats (opc, arg1, arg2, arg3)

   l.d   f2,4(r1)  encodes as:  opc, r1, f2, 4
   l.d   f4,8(r3)  encodes as:  opc, r3, f4, 8
   mul.d f6,f2,f4  encodes as:  opc, f2, f4, f6
   add.d f8,f4,f6  encodes as:  opc, f4, f6, f8
   s.d   f6,8(r3)  encodes as:  opc, r3, f6, 8
   s.d   f8,4(r5)  encodes as:  opc, r5, f8, 4

Of course, I use decimal digits for arguments because I don't want
you to do string processing.  They are the digits you see above,
with no lower-case Roman letters in front.  (I put some letters
in my print statements).

2. Box Behavior

f-box: Kind of obvious.  By the way, my machine has instruction-addressed
memory, so the 'for' loop has the correct increment.

d-box: Decode (decompose) instruction.  Set 'opc'.  Localize all
register operands from the RF.  Set either 'dest' or 'value_to_store'.
Set the two data outputs to the x-box ('D_Out1' and 'D_Out2').  This
is a case statement because you need to know the value of 'opc' in
order to choose the right behavior.  There are no extra marks for the
elegance of your case statements.

x-box: Calculate the memory address or perform the specified arithmetic
instruction.  Set 'X_Out'.  Remember: There are only integers in this
program.

m-box: Either bring in the floating-point value from memory at the
memory address or use a previously localized operand to push a value
to memory at the memory address.  Set 'M_Out'.  Ask 'opc'.

w-box: If there is a destination register (ask 'opc'), push the
appropriate result value to it, perhaps a loaded value, perhaps a
computed value.

Please note that both the m-box and the w-box may do nothing during
a cycle, depending on 'opc'.  I finally added the print statement
"Ddid nothing." to three of my boxes as a default option, because it
gives a clearer big picture.  Do the same.

You understand that your program's output is an essential window
into your source code.  That's why I insist on a single, integrated
plaintext file consisting of your source code, to which your output
has been appended as a comment.  In that way, we can run your
program and see if your program _does_ produce that output.

3. Walkthrough of the Assignment-Provided d-box Code

Now, suppose the case is an arithmetic statement.  In this case,
'arg2' is also the specifier of an operand register that needs
to be localized.  Hence, we perform the same action as above.
But now, in addition, we need to set 'dest' to the specifier
of the destination register, in this case, 'arg3'.

This is all the code I provided.  You finish the d-box code by
deciding what to do in the case of a load and what to do in
the case of a store.  For the remaining boxes, you will do
something similar, but will now take advantage of the global
variables (all shown in the assignment) that have been given
a value by earlier boxes.