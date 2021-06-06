#Question Number 2: CSC510
#Required Python 3.7.3

#Repeated Numeral
import random;
secretCode = [0,0,0,0];
playerCode = [0,0,0,0];
codeStatus=["\t","\t","\t","\t"];
surrenderCode = [0,0,0,0];
words = ["First(1)","Second(2)","Third(3)","Final(4)"];

#Gemerate Random Num (May cause repeated numeral)
def genNum():
    for i in range(4):
        secretCode[i] = random.randint(0,9);
    
genNum();
#print "Code",secretCode;

print ("Welcome to Master mind \n Repeated Numeral");
ext = 0;
while ext == 0:
    print ("Hit : Correct Number but wrong position");
    print ("Sink: Correct Number and correct position");
    for i in range(4):
        print ("Enter",words[i],"code :");
        playerCode[i] = int(input());

        for j in range(4):
            if playerCode[i] == secretCode[i]:
                #print ("Sink");
                #2 to indicate 'Sink'
                codeStatus[i] = "Sink\t"; 
                break;
            elif playerCode[i] == secretCode[j]:
                #print ("Its a hit");
                #1 to indicate 'Hit'
                codeStatus[i] = "Hit\t";
                break;
            else:
                codeStatus[i] = "\t";
                
    print ("\nCode Report");
    print (playerCode[0],"\t",playerCode[1],"\t",playerCode[2],"\t",playerCode[3]);
    print (codeStatus[0]+codeStatus[1]+codeStatus[2]+codeStatus[3]);

    if playerCode == surrenderCode:
        print ("\n\nYou have surrender");
        print (secretCode);
        ext = 1;
        
    if playerCode == secretCode:
        print ("\nCONGRATULATION\nYou have win");
        ext = 1;
    else:
        print ("\n\nTry again");
        val = 1;
        ext = 0;
    

        


