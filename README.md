The ISA power benchmarks process will get implemented in several stages.
1st stage is the Generation of the RISC-V assembly code template.
2nd stage is compiling and simulating this assembly code on the bluespec RISC-V explorer tool to get (idea/best logic) about the correctness of the assembly code template aiming ISA power benchmark. 
#So assembly code template got generated successfully.
#The big question How to do compilation and simulation on the mentioned tool, now this thing I will discuss in several steps.
step 1 -: Download and install bluespec RISC-V explorer tool on your device.
Follow this link : https://s3.wasabisys.com/bluespec/downloads/riscvexplorer/1.202010.1/097494537733/user-guide.html?__hstc=239440412.517830d4cf351f80d375dd0d20bc6236.1620451026369.1622178058792.1622380965520.6&__hssc=239440412.1.1622380965520&hsCtaTracking=de8dcdd9-6a73-4da3-b770-850145280dbe%7C1f3131df-5320-4771-86c5-3d8f804a00e4 
step 2: I have uploaded the make file. create an assembly directory, put this make file in your assembly directory.
step 3: Inside the assembly directory create another directory where u will write your assembly code (.s extension ) file.
step 4: Just open your terminal window inside the assembly directory and write the command $ make and enter this command, u will get your assembly code compilation successfully. 
Now final step: how to run this compiled code on bluespec RISC-V explorer tool ? 
answer: Open the terminal window inside your assembly directory and follow this command in order:-
$source /opt/bluespec/riscvexplorer/setup.sh
$make all
$riscvexplorer-simulation-launch-standalone code template vicky/c_miss
#here as an example I have taken vicky is as the code template directory name, and c_miss is the assembly code that is saved inside this directory in .s extension.
