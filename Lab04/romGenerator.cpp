#include<iostream>
#include<fstream>
#include<math.h>
using namespace std;
string decToBin(string b,int n,int idx)
{
    if(n==0) return b;
    else if(n%2==0)
    {
        b[idx] = '0';
        return decToBin(b,n/2,idx-1);
    }
    else
    {
         b[idx] = '1';
        return decToBin(b,n/2,idx-1);
    }
}
int main()
{
    ofstream f("rom.dat");
    for(int i=0;i<1024;i++)
    {
        string b = decToBin("00000",(int)sqrt(i),4);
        cout<<b<<endl;
        f<<b<<endl;
    }
    f.close();
    return 0;
}
