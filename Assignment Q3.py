#Question Number 3: CSC510
#Required Python 3.7.3

coinSet = [1.0,0.5,0.2,0.1,0.05,0.01];
coinNum = [0,0,0,0,0,0];

print ("Enter Value: RM");
coinValue = float(input());

for i in range(6):
    #Python Floating Float Arithmetic Fixes by +0.001 to coinValue in reasignment
    if coinValue >= coinSet[i]:
        coinNum[i] = int(coinValue / coinSet[i]);
        coinValue = (coinValue + 0.001) % coinSet[i];
        print ("Required x",coinNum[i],"of",coinSet[i],"coin");


input();
       
        
