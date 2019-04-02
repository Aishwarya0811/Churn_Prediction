Codes
DATA wage;
INFILE 'H:\SAS\Homework 4\WAGE2.dat' firstobs=2;
INPUT csid tsid edu hr wage famearn selfempl salaried  married numkid age locunemp;
RUN;
data Fwage;set wage;
lnwage = log(wage);edusqd = edu*edu;hrsqd = hr*hr;
edsalint = edu*salaried; ageunein = age*locunemp;salself = salaried*selfempl;
run;
PROC PRINT data=Fwage (obs=10);run;

/Q1.1/
proc reg data=Fwage;
model lnwage = age edu numkid hr married salaried selfempl locunemp edsalint ageunein salself/ VIF stb COLLIN;    
run;

*Q1.2;
proc reg data=Fwage;
model lnwage = age edu numkid hr married salaried selfempl locunemp edsalint ageunein salself edusqd hrsqd;    
run;

*Q1.3;

proc panel data=Fwage outest=estimates(rename=(TYPE=Model));
id csid tsid;
model lnwage=age edu numkid hr married salaried selfempl locunemp edsalint ageunein salself/fixone;
model lnwage=age edu numkid hr married salaried selfempl locunemp edsalint ageunein salself/ranone bp2;
model lnwage=age edu numkid hr married salaried selfempl locunemp edsalint ageunein salself/fixtwo;
model lnwage=age edu numkid hr married salaried selfempl locunemp edsalint ageunein salself/rantwo bp2;
model lnwage=age edu numkid hr married salaried selfempl locunemp edsalint ageunein salself/pooled;
run;

proc print data=estimates(drop=_: lnwage);run;

*Q1.4;

proc model data=Fwage;
parms b0 b1 b2 b3 b5 b6 b7 b8 b9 b10 b11; 
lnwage=b0+b1*age+ b2*edu+ b3*numkid+b4*hr+b5*married+b6*salaried+b7*selfempl+b8*locunemp+b9*edsalint+b10*ageunein+b11*salself;
fit lnwage / white out=resid1 outresid;run;
