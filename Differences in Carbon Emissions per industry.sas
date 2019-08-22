PROC IMPORT OUT= CO2 
            DATAFILE= "/folders/myfolders/SASDATA/carbon-emissions-borough.xls"
            DBMS=xls REPLACE;
     GETNAMES=YES;
     DATAROW=2;
RUN;
*PROC PRINT DATA=CO2;
*RUN;

*Paired T-Test per Industry Sector;
PROC TTEST;
PAIRED IC_2005*IC_2014;
TITLE 'Paired t-test Industry and Commercial';
RUN;

PROC TTEST;
PAIRED D_2005*D_2014;
TITLE 'Paired t-test Domestic';
RUN;

PROC TTEST;
PAIRED T_2005*T_2014;
TITLE 'Paired t-test Transport';
RUN;

PROC TTEST;
PAIRED GT_2005*GT_2014;
TITLE 'Paired t-test Transport';
RUN;

*Log Transform Variables to normalize distribution;
DATA LogDiff;
   set CO2;
   IC_2005 = Log10(IC_2005);
   IC_2014 = Log10(IC_2014);
   D_2005 = Log10(D_2005);
   D_2014 = Log10(D_2014);
   T_2005 = Log10(T_2005);
   T_2014 = Log10(T_2014);
   GT_2005 = Log10(GT_2005);
   GT_2014 = Log10(GT_2014);
   IC_Diff = IC_2005 - IC_2014;
   D_Diff = D_2005 - D_2014;
   T_Diff = T_2005 - T_2014;
   GT_Diff = GT_2005 - GT_2014;
RUN;
*PROC PRINT data=LogDiff;
   *var Name IC_2005 IC_2014 IC_Diff D_2005 D_2014 D_Diff T_2005 T_2014 T_Diff 
   GT_2005 GT_2014 GT_Diff;
   *title 'CO2 Emissions';
*RUN;

*Rerun Paired Samples T-Test;
PROC TTEST;
PAIRED IC_2005*IC_2014;
TITLE 'Paired t-test Industry and Commercial';
RUN;

PROC TTEST;
PAIRED D_2005*D_2014;
TITLE 'Paired t-test Domestic';
RUN;

PROC TTEST;
PAIRED T_2005*T_2014;
TITLE 'Paired t-test Transport';
RUN;

PROC TTEST;
PAIRED GT_2005*GT_2014;
TITLE 'Paired t-test Grand Total';
RUN;

*Paired T-Test bewteen Industry Sector;
PROC TTEST;
PAIRED IC_Diff*D_Diff;
TITLE 'Paired t-test Industry and Commercial Vs Domestic';
RUN;

PROC TTEST;
PAIRED IC_Diff*T_Diff;
TITLE 'Paired t-test Industry and Commercial Vs Transport';
RUN;

PROC TTEST;
PAIRED D_Diff*T_Diff;
TITLE 'Paired t-test Domestic Vs Transport';
RUN;

proc univariate data=LOGDIFF;
   var IC_Diff D_Diff T_Diff;
run;