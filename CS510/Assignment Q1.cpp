//Question Number 1: CSC510

#include <iostream>
#include <iomanip>
using namespace std;

void alternatifSearch(int, int, int,int &,int &,int &);
bool analysis(int,int,int);
void showResult(int,int,int,int,int,int);

//Global Variable
int globalCount = 0;
char population[999];
int WHEEL = 60;
int LIGHT = 100;
int altUsedW = 0;
int altUsedL = 0;
int reqWheel = 0;
int reqLight = 0;
int altWheel, altLight;
int projectedRev = 0;
float Revenue1, Revenue2;
	
int main()
{
	int globalCount = 0;
	
	int bike,wheel,car;
	int maxB1,maxC1,maxW1;
	bool available;
	float price1,price2;
	char ans='Y';
	
	while(ans=='Y')
	{
		cout<<"How many Bike? :";
		cin>>bike;
		cout<<"How many Wheel? :";
		cin>>wheel;
		cout<<"How many Firefighter Car? :";
		cin>>car;
		
		available = analysis(bike,wheel,car);
	
		if(available)
		{
		   alternatifSearch(car, bike, wheel, maxC1, maxB1, maxW1);
	       ans='N';
	       showResult(car,bike,wheel,maxC1,maxB1,maxW1);  
		}
		else
		{
			cout << "\nInsufficient Material\n" << endl;
			ans='Y';
		} 
    }
	return 0;
	
	
}

void alternatifSearch(int car, int bike, int wheel, int &maxC, int &maxB, int &maxW)
{	
		
	altLight = reqLight;
	altWheel = reqWheel;
	if((reqLight / 6) > 0 && (altWheel / 4) > 0)
	{
		maxC = altLight/6;
		altLight -= maxC*6;
		altWheel -= maxC*4;
	}
	
	if((altLight / 2) > 0 && (altWheel / 2) >0)
	{
		maxB = altLight/2;
		altLight -= maxC*2;
		altWheel -= maxC*2;
	}
	
	if((altLight / 2) > 0 && (altWheel > 0))
	{
		maxW = altLight/2;
		altLight -= maxC*2;
		altWheel -= maxC*1;
	}
		
	if(maxC==car && maxB==bike && maxW==wheel)
	{
		if(car > 0)
		{
			maxC--;
			maxB++;
			maxW++;
		}
		else if(bike > 0)
		{
			maxB--;
			maxW++;
		}
	}
	altUsedL = (maxC*6)+(maxB*2)+(maxW*2);
	altUsedW = (maxC*4)+(maxB*2)+(maxW*1);
	Revenue2 = (maxC*150) + (maxB * 40) + (maxW * 30);
}

bool analysis(int bike1,int wheel1,int car1)
{
	bool available;
		reqWheel += bike1*2;
		reqLight += bike1*2;

		reqWheel += wheel1*2;
		reqLight += wheel1*1;
		
		reqWheel += car1* 4;
		reqLight += car1*6;
	if(reqWheel <= WHEEL && reqLight <= LIGHT)
		available = true;
	else
	{
		available = false;
		reqWheel=0;
		reqLight=0;
	}
	
	Revenue1= car1*150 + bike1*40 + wheel1*30;	
	return available;
}

void showResult(int car1, int bike1, int wheel1, int maxC, int maxB, int maxW)
{
	cout<<"\n\nREQUESTED"<<" \t\t\t|| "<<"ALTERNATIVE\n";
	cout<<"NO. OF BIKE : "<<bike1<<" \t\t|| "<<"NO. OF BIKE : "<<maxB<<endl;
	cout<<"NO. OF WHEELBURROW : "<<wheel1<<" \t\t|| "<<"NO. OF WHEELBURROW : "<<maxW<<endl;
	cout<<"NO. OF FIREFIGTHER CAR : "<<car1<<" \t|| "<<"NO. OF FIREFIGHTER CAR: "<<maxC<<endl;
	cout<<"NO. OF LIGHT USED : "<<reqLight<<" \t\t|| "<<"NO. OF LIGHT USED : "<<altUsedL<<endl;
	cout<<"NO. OF WHEEL USED : "<<reqWheel<<" \t\t|| "<<"NO. OF WHEEL USED : "<<altUsedW<<endl;
	cout<<"NO. OF LIGHT UNUSED :"<<LIGHT - reqLight<<"/100 \t|| "<<"NO. OF LIGHT UNUSED : "<<LIGHT - altUsedL<<"/100"<<endl;
	cout<<"NO. OF WHEEL UNUSED :"<<WHEEL - reqWheel<<"/60 \t|| "<<"NO. OF WHEEL UNUSED : "<<WHEEL - altUsedW<<"/60"<<endl;
	cout<<"TOTAL REVENUE : RM"<<Revenue1<<" \t\t|| "<<"TOTAL REVENUE : RM"<<Revenue2<<endl;
}


