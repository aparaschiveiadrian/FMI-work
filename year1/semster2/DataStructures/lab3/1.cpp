#include <iostream>
#include <stack>
using namespace std;
bool esteBun(string s){
    stack <char> paranteze;
    long long lungime = s.size();
    if(lungime %2 ==1)
        return false;
    else
    {
        for(int i = 0; i< lungime; i++)
        {
            if(s[i] == '(' || s[i] == '[' || s[i] == '{' || paranteze.empty())
                paranteze.push(s[i]);
            else if (s[i] == ')')
            {
                if(paranteze.top() == '(')
                {
                    paranteze.pop();
                }
                else
                    return false;
            }
            else if (s[i] == ']')
            {
                if(paranteze.top() == '[')
                {
                    paranteze.pop();
                }
                else
                    return false;
            }
            else if (s[i] == '}')
            {
                if(paranteze.top() == '{')
                {
                    paranteze.pop();
                }
                else
                    return false;
            }
        }
    }
    if(paranteze.empty())
        return true;
    else
        return false;
}
int main() {

    string sir;
    cin >> sir;
    cout<< esteBun(sir);
    return 0;
}
