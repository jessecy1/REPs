 clear
use Vars.dta, clear
xtset  id year
foreach v in CE PGDP JA IS PS EC ///
 EI_EL IS_Ind1 ES_Fo RE REC CI PD CE90 {
    gen ln`v' = log(`v'+0.01) 
} 
gen lnFDI = cond(FDI > 0, ln(FDI+0.01), -ln(abs(FDI)+0.01))
global cv "lnPGDP lnJA lnIS lnPS lnFDI" 
global cvy "lnPGDP lnJA lnIS lnPS lnFDI i.year" 
**Table 1 Descriptive statistics.
sum lnCE P_RE PT_RI PT_PS PT_EI PT_RD PT_VA PT_IE ///
lnPGDP lnJA lnIS lnPS lnFDI ///
RE lnEI_EL lnES_Fo lnPD lnIS_Ind1 lnEC lnREC ///
CC RL BAtype BAtarget

**Table 2 The carbon reduction effects of REPs.
  xtscc lnCE P_RE $cvy, fe lag(1)
  xtscc lnCE P_RE i.year, fe lag(1)
  xtscc lnCE PT_RI PT_PS PT_EI PT_RD PT_VA PT_IE $cvy, fe lag(1) 

**Table 3 Results of robustness analysis.
  xtscc lnCI  P_RE $cvy ///
  , fe lag(1)
  xtscc lnEC  P_RE $cvy ///
  , fe lag(1)
  xtscc lnCE  P_RE lnPGDP lnJA lnIS_Ind1 lnPD lnFDI i.year ///
  , fe lag(1) 
  xtscc lnCE P_RE $cvy lnEI_EL lnES_Fo i.year ///
  , fe lag(1)
  xtscc lnCE  L.(P_RE $cv) i.year ///
  , fe lag(1)
gen IV_PRE=lnCE90*L.P_RE
xi:xtivreg2 lnCE $cvy  ///
(P_RE=L.P_RE IV_PRE), gmm2s fe robust  

winsor2 lnCE P_RE lnPGDP lnJA lnIS lnPS lnFDI, replace cuts(1 99) 
  xtscc lnCE P_RE $cvy ///
  , fe lag(1) 
  
use Vars.dta, clear
xtset  id year
foreach v in CE PGDP JA IS PS EC ///
 EI_EL IS_Ind1 ES_Fo RE REC CI PD CE90 {
    gen ln`v' = log(`v'+0.01) 
} 
gen lnFDI = cond(FDI > 0, ln(FDI+0.01), -ln(abs(FDI)+0.01))
global cv "lnPGDP lnJA lnIS lnPS lnFDI" 
global cvy "lnPGDP lnJA lnIS lnPS lnFDI i.year" 
**Table 4. Heterogeneity analyses of REPs on carbon emissions.
  center P_RE lnEI_EL CC RL BAtype BAtarget, replace

  gen P_RE_EI=c_P_RE*c_lnEI_EL
  gen P_RE_CC=c_P_RE*c_CC
  gen P_RE_RL=c_P_RE*c_RL
  gen P_RE_BAtype=c_P_RE*c_BAtype
  gen P_RE_BAtarget=c_P_RE*c_BAtarget
  
  xtscc lnCE P_RE lnEI_EL P_RE_EI lnPGDP lnJA lnIS lnPS lnFDI i.year ///
  , fe lag(1)
  xtscc lnCE P_RE CC P_RE_CC lnPGDP lnJA lnIS lnPS lnFDI i.year ///
  , fe lag(1)  
  xtscc lnCE P_RE RL P_RE_RL lnPGDP lnJA lnIS lnPS lnFDI i.year ///
  , fe lag(1) 
  xtscc lnCE P_RE BAtype P_RE_BAtype lnPGDP lnJA lnIS lnPS lnFDI i.year ///
  , fe lag(1)   
  xtscc lnCE P_RE BAtarget P_RE_BAtarget lnPGDP lnJA lnIS lnPS lnFDI i.year ///
  , fe lag(1)  

**Table 5. Mediation effect results. 
sgmediation2 lnCE, mv(lnREC) iv(P_RE) ///
cv(lnPGDP lnJA lnIS lnPS lnFDI i.id i.year)	vce(bootstrap, reps(500)) 
sgmediation2 lnCE, mv(RE) iv(P_RE) ///
cv(lnPGDP lnJA lnIS lnPS lnFDI i.id i.year)	vce(bootstrap, reps(500))

reg lnCE P_RE lnREC lnPGDP lnJA lnIS lnPS lnFDI
vif
reg lnCE P_RE RE lnPGDP lnJA lnIS lnPS lnFDI
vif

**Table 6. Analyses of substitution effects.
  xtscc PFEC PREC i.year ///
  , fe lag(1)
  xtscc PFEC PREC lnPGDP lnJA lnIS lnPS lnFDI i.year ///
  , fe lag(1)
  xtscc PFoEP PREP i.year ///
  , fe lag(1) 
  xtscc PFoEP PREP lnPGDP lnJA lnIS lnPS lnFDI i.year ///
  , fe lag(1)

**Fig. 2 The lag effects of RES and REC on carbon emissions.

xtscc lnCE P_RE L.RE  $cvy, fe lag(1) 
xtscc lnCE P_RE L2.RE $cvy, fe lag(1)
xtscc lnCE P_RE L3.RE $cvy, fe lag(1)
xtscc lnCE P_RE L4.RE $cvy, fe lag(1)
xtscc lnCE P_RE L5.RE $cvy, fe lag(1)
xtscc lnCE P_RE L6.RE $cvy, fe lag(1)
xtscc lnCE P_RE L7.RE $cvy, fe lag(1)
xtscc lnCE P_RE L8.RE $cvy, fe lag(1)
xtscc lnCE P_RE L9.RE $cvy, fe lag(1)
xtscc lnCE P_RE L10.RE $cvy, fe lag(1)
xtscc lnCE P_RE L11.RE $cvy, fe lag(1)
xtscc lnCE P_RE L12.RE $cvy, fe lag(1)

xtscc lnCE P_RE lnREC  $cvy, fe lag(1) 
xtscc lnCE P_RE L.lnREC  $cvy, fe lag(1) 
xtscc lnCE P_RE L2.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L3.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L4.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L5.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L6.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L7.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L8.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L9.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L10.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L11.lnREC $cvy, fe lag(1)
xtscc lnCE P_RE L12.lnREC $cvy, fe lag(1)

**Fig.3 The heterogeneous effects of renewables on carbon emissions.
*REP starting time
xtscc lnCE P_RE RE lnPGDP lnJA lnIS lnPS lnFDI i.year if start2<5, fe lag(1)	
xtscc lnCE P_RE RE lnPGDP lnJA lnIS lnPS lnFDI i.year if start2>=5&start2<10, fe lag(1)	
xtscc lnCE P_RE RE lnPGDP lnJA lnIS lnPS lnFDI i.year if start2>=10&start2<15, fe lag(1)	
xtscc lnCE P_RE RE lnPGDP lnJA lnIS lnPS lnFDI i.year if start2>=15&start2<20, fe lag(1)	
xtscc lnCE P_RE RE lnPGDP lnJA lnIS lnPS lnFDI i.year if start2>=20, fe lag(1)
*Geographical location
 xtscc lnCE P_RE RE $cvy if continent=="Asia", fe lag(1)
 xtscc lnCE P_RE RE $cvy if continent=="Europe", fe lag(1)
 xtscc lnCE P_RE RE $cvy if continent=="Africa", fe lag(1)
 xtscc lnCE P_RE RE $cvy if continent=="NorthAmerica", fe lag(1)
 xtscc lnCE P_RE RE $cvy if continent=="SouthAmerica", fe lag(1)
 xtscc lnCE P_RE RE $cvy if continent=="Oceania", fe lag(1)
 xtscc lnCE P_RE RE $cvy if continent=="Europe"&eu==0 , fe lag(1)
*Organizational affiliation
 xtscc lnCE P_RE RE $cvy if eu==1, fe lag(1)
 xtscc lnCE P_RE RE $cvy if asean==1, fe lag(1)
 xtscc lnCE P_RE RE $cvy if africanunion==1, fe lag(1)
 xtscc lnCE P_RE RE $cvy if brics==1, fe lag(1)
 xtscc lnCE P_RE RE $cvy if opec==1, fe lag(1)
 xtscc lnCE P_RE RE $cvy if oecd==1, fe lag(1)

*Economic level, industrialization level, population size, initial carbon emissions 
tabstat PGDP PS PIO2 , statistics(mean)
tabstat CE if year==2000 , statistics(mean)
/*   stats |      PGDP        PS      PIO2
---------+------------------------------
    mean |  13536.99  4.79e+07  29434.37
    variable |      mean
-------------+----------
          CE |  167563.3*/
xtscc lnCE P_RE RE $cvy if PGDP>13536.99& PGDP!= ., fe lag(1)
xtscc lnCE P_RE RE $cvy if PGDP<13536.99, fe lag(1)
xtscc lnCE P_RE RE $cvy if PIO2>29434.37& PIO2!= ., fe lag(1) 
xtscc lnCE P_RE RE $cvy if PIO2<29434.37, fe lag(1) 
xtscc lnCE P_RE RE $cvy if PS>4.79e+07& PS!= ., fe lag(1)
xtscc lnCE P_RE RE $cvy if PS<4.79e+07, fe lag(1)

gen CE2000 = (CE > 167563) if year == 2000
bysort id : egen min_CE2000 = min(CE2000)
replace CE2000 = min_CE2000 
 xtscc lnCE P_RE RE $cvy if CE2000==1, fe lag(1)
 xtscc lnCE P_RE RE $cvy if CE2000==0, fe lag(1)

**Table 7. The nonlinear relationship between RES and carbon reductions.
  gen RE2 =RE *RE
  xtscc lnCE P_RE RE RE2 lnPGDP lnJA lnIS lnPS lnFDI i.year ///
   , fe lag(1)



