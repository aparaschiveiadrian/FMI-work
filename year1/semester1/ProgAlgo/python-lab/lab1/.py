#ex2
n = int(input("n="))
dayprev = float(input())
daynow = float(input())
indexprevmax=1
indexnowmax=2
maxim = daynow - dayprev
for i in range(3, n+1):
    dayprev =daynow
    daynow = float(input())
    maxim_temp = daynow - dayprev
    if maxim_temp> maxim:
        maxim = maxim_temp
        indexprevmax = i-1
        indexnowmax = i
print("cea mai mare crestere a fost inregistrata intre zilele ",indexprevmax,indexnowmax,"aceasta fiind de", round(maxim,2))


#ex3

def cmmdc(m,n):
    if m< n:
        (m,n) = (n,m)
    if(m%n) == 0:
        return n
    else:
        return (cmmdc(n, m % n))
l1 = int(input("l1 = "))
l2 = int(input("l2 = "))
len = cmmdc(l1,l2)
print((l1//len)*(l2//len))

#ex4

