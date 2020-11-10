
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
begin 


; Script used for Popp, Bony and Lutsko (2020): Weaker links between zonal convective clustering and
; ITCZ width in climate models than in observations, GRL
;
; Creates Figure 3 (Variances_E_budget.eps) and Supplementary Figure S5 (Variances_cl_E_budget.eps)
;
; Calculates necessary correlations and r^2 values used for Supplementary Tables S5 and S6 



file_names=new (18,string)
file_names(0)="GPCP"

file_names(1)="ACCESS1-3_rtoatm"
file_names(2)="bcc-csm1-1"
file_names(3)="BNU-ESM"
file_names(4)="CanAM4"

;file_names(5)="CMCC-CM"
file_names(5)="CCSM4"
file_names(6)="CNRM-CM5"
file_names(7)="FGOALS-s2"

file_names(8)="GFDL-CM3_o"
file_names(9)="GFDL-HIRAM-C360_o"
file_names(10)="IPSL-CM5A-MR"
file_names(11)="MIROC5"

file_names(12)="MIROC-ESM"
file_names(13)="MPI-ESM-LR"

file_names(14)="MPI-ESM-MR"
file_names(15)="MRI-AGCM3-2S"
file_names(16)="MRI-CGCM3"
file_names(17)="NorESM1-M"


;file_names(17)="GPCP"
;file_names(11)="HadGEM2-A_rtoatm"
;file_names(13)="IPSL-CM5A-MR"
;file_names(15)="MRI-AGCM3-2S"
;file_names(7)="EC-EARTH"
;file_names(11)="GISS-E2-R"
;file_names(12)="inmcm4"

yearmonday="19961001-20081231"
yearmon="199610-200812"

m_number=dimsizes(file_names)







 a_Earth = 6.371e6
 PI      = acos(-1.)
 grav = 9.81

 c_p=1006.
 L_v=2257000.


 index_lat=15.
 eq_lat = 5.
 crit_lat=25.

 m_days=31






  min_cluster   = new(m_number ,float)
  max_cluster   = new(m_number ,float)
  mean_cluster  = new(m_number ,float)
  std_cluster   = new(m_number ,float)
  delta_cluster = new(m_number ,float)
  
  min_width_pr   = new(m_number ,float)
  max_width_pr   = new(m_number ,float)
  mean_width_pr  = new(m_number ,float)
  std_width_pr   = new(m_number ,float)
  delta_width_pr = new(m_number ,float)
  
  min_subs_size_lat   = new(m_number ,float)
  max_subs_size_lat   = new(m_number ,float)
  mean_subs_size_lat  = new(m_number ,float)
  std_subs_size_lat   = new(m_number ,float)
  delta_subs_size_lat = new(m_number ,float)


  
  mean_subs_frac  = new(m_number ,float)
  std_subs_frac   = new(m_number ,float)

  mean_TOT_rad  = new(m_number ,float)
  std_TOT_rad   = new(m_number ,float)

  mean_ACRE  = new(m_number ,float)
  std_ACRE   = new(m_number ,float)

  mean_TURB  = new(m_number ,float)
  std_TURB   = new(m_number ,float)

  mean_UPTAKE  = new(m_number ,float)
  std_UPTAKE   = new(m_number ,float)

  mean_TS_sym  = new(m_number ,float)
  std_TS_sym   = new(m_number ,float)
 
  
  reg_line_cl_width = new(m_number ,float)
  corr_cl_width     = new(m_number ,float)

  reg_line_cl_tophe = new(m_number ,float)
  corr_cl_tophe     = new(m_number ,float)

  reg_line_cl_ssl   = new(m_number ,float)
  corr_cl_ssl       = new(m_number ,float)


  corr_cl_uptake = new(m_number ,float)
  corr_sf_uptake = new(m_number ,float)

  corr_sf_wpr = new(m_number ,float)
  corr_cl_wpr = new(m_number ,float)
  corr_sf_wdy = new(m_number ,float)
  corr_cl_wdy = new(m_number ,float)


  min_cluster_sym   = new(m_number ,float)
  max_cluster_sym   = new(m_number ,float)
  mean_cluster_sym  = new(m_number ,float)
  std_cluster_sym   = new(m_number ,float)
  delta_cluster_sym = new(m_number ,float)
  
  min_width_pr_sym   = new(m_number ,float)
  max_width_pr_sym   = new(m_number ,float)
  mean_width_pr_sym  = new(m_number ,float)
  std_width_pr_sym   = new(m_number ,float)
  delta_width_pr_sym = new(m_number ,float)
  
  min_subs_size_lat_sym   = new(m_number ,float)
  max_subs_size_lat_sym   = new(m_number ,float)
  mean_subs_size_lat_sym  = new(m_number ,float)
  std_subs_size_lat_sym   = new(m_number ,float)
  delta_subs_size_lat_sym = new(m_number ,float)


  mean_subs_frac_sym  = new(m_number ,float)
  std_subs_frac_sym   = new(m_number ,float)  

  mean_TOT_rad_sym  = new(m_number ,float)
  std_TOT_rad_sym   = new(m_number ,float)

  mean_ACRE_sym  = new(m_number ,float)
  std_ACRE_sym   = new(m_number ,float)

  mean_TURB_sym  = new(m_number ,float)
  std_TURB_sym   = new(m_number ,float)

  mean_UPTAKE_sym  = new(m_number ,float)
  std_UPTAKE_sym   = new(m_number ,float)

  mean_cluster_tas_sym  = new(m_number ,float)
  std_cluster_tas_sym   = new(m_number ,float)


  reg_line_cl_width_sym = new(m_number ,float)
  corr_cl_width_sym     = new(m_number ,float)

  reg_line_cl_tophe_sym = new(m_number ,float)
  corr_cl_tophe_sym     = new(m_number ,float)

  reg_line_cl_ssl_sym   = new(m_number ,float)
  corr_cl_ssl_sym       = new(m_number ,float)



  RMSE_cluster       = new (m_number ,float)
  RMSE_width_pr      = new (m_number ,float)
  RMSE_subs_size_lat = new (m_number ,float)
  RMSE_subs_frac     = new (m_number ,float)


  RMSE_cluster_sym  = new (m_number ,float)
  RMSE_width_pr_sym = new (m_number ,float)
  RMSE_subs_size_lat_sym = new (m_number ,float)
  RMSE_subs_frac_sym     = new (m_number ,float)


  corr_sf_ACRE_sym   = new(m_number ,float)
  corr_sf_TURB_sym   = new(m_number ,float)
  corr_sf_RAD_sym    = new(m_number ,float)
  corr_sf_UPTAKE_sym = new(m_number ,float)

  corr_sf_delta_uptake_sym = new(m_number ,float)
  corr_sf_uptake_10_16_sym = new(m_number ,float)
  
  corr_sf_shallow_sym = new(m_number ,float)
  corr_sf_cenpres_sym = new(m_number ,float)
  corr_sf_top_sym     = new(m_number ,float)
  sign_sf_top_sym     = new(m_number ,float)

  corr_sf_dphi_Ts_sym  = new(m_number ,float)
  corr_sf_dphi_MSE_sym = new(m_number ,float)
  corr_sf_Ts_sym       = new(m_number ,float)



  corr_cl_ACRE_sym   = new(m_number ,float)
  corr_cl_TURB_sym   = new(m_number ,float)
  corr_cl_RAD_sym    = new(m_number ,float)
  corr_cl_UPTAKE_sym = new(m_number ,float)

  corr_cl_delta_uptake_sym = new(m_number ,float)
  corr_cl_uptake_10_16_sym = new(m_number ,float)
  
  corr_cl_shallow_sym = new(m_number ,float)
  corr_cl_cenpres_sym = new(m_number ,float)
  corr_cl_top_sym     = new(m_number ,float)
  sign_cl_top_sym     = new(m_number ,float)

  corr_cl_dphi_Ts_sym  = new(m_number ,float)
  corr_cl_dphi_MSE_sym = new(m_number ,float)
  corr_cl_Ts_sym       = new(m_number ,float)


;================================================================
;Define reference fields with GPCP and ERA-Interim



  file1     = addfile("../FILES_AMIP/pr_day_"+file_names(0)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r")
  file_m    = addfile("../FILES_AMIP/pr_day_"+file_names(0)+"_amip_r1i1p1_"+yearmonday+"_mm_ZM.nc","r")

  file_w500    = addfile("../FILES_AMIP/wap500_Amon_"+file_names(0)+"_amip_r1i1p1_"+yearmon+"_mm_ZM.nc","r")
  file_w500_hr = addfile("../FILES_AMIP/wap500_day/wap500_day_"+file_names(0)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r")



  lat=file_m->lat
  lat_number=dimsizes(lat)
 
  lon = file1->lon
  lon_number = dimsizes(lon)



;=================================================


 time = file1->time
 time_number=dimsizes(time)

 utc_date =cd_calendar(time,0)
 time_counter=1
 month_change=new(time_number,float)
 month_change(:)=0.
 do j_time=2,time_number-1
   if(utc_date(j_time-1,1) .NE. utc_date(j_time-2,1)) then
     time_counter=time_counter+1
    month_change(j_time-1)=1.
   end if
 end do

month_days=new(time_counter,integer)

m_counter=0
j_month=0
do j_time=1,time_number
 if (month_change(j_time-1) .eq. 1.) then
   month_days(j_month) = m_counter
   j_month= j_month + 1 
   m_counter=1
 else 
   m_counter=m_counter+1
 end if
end do
month_days(time_counter-1) =m_counter


 days_since_start= new(time_counter,integer)
 days_since_start(0)=0
 do j_m=2,time_counter
   days_since_start(j_m-1)= days_since_start(j_m-2)+month_days(j_m-2)
 end do


 month_number=time_counter
;===================================================




;  printVarSummary(file1->pr)

  precip_hr_eq = new ((/time_number,lon_number/),float)
  precip_hr_eq(:,:) = file1->pr(:,0,:)


   precip_mm     = new((/month_number,lat_number/),float)
   precip_mm_o   = new((/month_number,lat_number/),float)
   precip_mm_o_2 = new((/month_number,lat_number/),float)

   ;printVarSummary(precip_mm)
   ;printVarSummary(file_m->pr)

   do j_m=1,month_number
     precip_mm(j_m-1,:) = 86400.*file_m->pr(j_m-1,:,0)
     ;precip_mm_o(j_m-1,:) = 86400.*file_m->pr(j_m-1,:,0)
     ;precip_mm_o_2(j_m-1,:) = wgt_runave_n(precip_mm_o(j_m-1,:),(/0.2,0.6,0.2/),0,0)
     ;precip_mm(j_m-1,:) = wgt_runave_n(precip_mm_o_2(j_m-1,:),(/0.2,0.6,0.2/),0,0)
   end do


  zonvar_eq_precip = new (time_number,float)
  zonavg_eq_precip = new (time_number,float)

  zonvar_eq_precip_m = new ((/month_number,m_days/),float)
  zonavg_eq_precip_m = new ((/month_number,m_days/),float)

  GPCP_tm_zonvar_eq_precip_m = new (month_number,float)
  GPCP_tm_zonavg_eq_precip_m = new (month_number,float)


  do j_t=1,time_number
      ;print(j_t-1)
      zonavg_eq_precip(j_t-1) = avg(precip_hr_eq(j_t-1,:))
      zonvar_eq_precip(j_t-1)  = sqrt(sum((precip_hr_eq(j_t-1,:) - zonavg_eq_precip(j_t-1))^2) /lon_number) /zonavg_eq_precip(j_t-1)
  end do

  
  do j_m=1,month_number
    ;print(j_m-1)
    ;print(days_since_start(j_m-1))
    ;print(days_since_start(j_m-1)+m_days-1)

    m_days=month_days(j_m-1)
    zonavg_eq_precip_m(j_m-1,0:(m_days-1)) = zonavg_eq_precip(days_since_start(j_m-1):(days_since_start(j_m-1)+m_days-1))
    zonvar_eq_precip_m(j_m-1,0:(m_days-1)) = zonvar_eq_precip(days_since_start(j_m-1):(days_since_start(j_m-1)+m_days-1))

    GPCP_tm_zonvar_eq_precip_m(j_m-1) = avg(zonvar_eq_precip_m(j_m-1,:))
    GPCP_tm_zonavg_eq_precip_m(j_m-1) = avg(zonavg_eq_precip_m(j_m-1,:))
  end do

 delete(zonvar_eq_precip_m)
  delete(zonavg_eq_precip_m)

  delete(zonvar_eq_precip)
  delete(zonavg_eq_precip)

  delete(precip_hr_eq)

  

  omega500_hr_eq=new ((/time_number,lon_number/),float)

 ; printVarSummary(file_w500_hr->w(:,0,0,:))
 ; printVarSummary(omega500_hr_eq)

  omega500_hr_eq(:,:) = 864.*file_w500_hr->w(:,0,0,:)
 
  ;Subsidence fraction
  ERA_subs_frac_tm   = new (month_number,float)
  ;subs_frac_tm_d = new ((/file_number,file_number/),float)
  do j_f=1,month_number
    m_days=month_days(j_f-1)
    subs_frac=new(m_days,float)
    do j_t=1,m_days
      omeg_counter=0.
        do j_lon=1,lon_number
          if ( omega500_hr_eq(days_since_start(j_f-1)+j_t-1,j_lon-1) .lt. 0.) then 
           omeg_counter = omeg_counter + 1.
          end if
        end do
      subs_frac(j_t-1) = (tofloat(lon_number)-omeg_counter)/tofloat(lon_number)
    end do
    ERA_subs_frac_tm(j_f-1)         = avg(subs_frac(:))
    ;subs_frac_tm_d(j_f-1,j_f-1) = avg(subs_frac(:))
    delete(subs_frac)
  end do

  delete(omega500_hr_eq)







  pr_Ii        = new(month_number,integer)

 

  do j_lat=toint(lat_number/3),toint(2*lat_number/3)
    if(lat(j_lat-1) .GE. -crit_lat .AND. lat(j_lat-2) .LT. -crit_lat) then 
      c_ST = j_lat-1
    end if
    if(lat(j_lat) .GE. crit_lat .AND. lat(j_lat-1) .LT. crit_lat) then 
      c_NT = j_lat-1
    end if
  end do

  do j_time=1,month_number
    pr_Ii(j_time-1) = c_ST + maxind(precip_mm(j_time-1,c_ST:c_NT))
  end do

  delete(c_ST)
  delete(c_NT)




 omega500_m_lat = new ((/month_number,lat_number/),float)
 ERA_subs_size_lat = new ((/month_number/),float)

 ;printVarSummary(omega500_m_lat)
 ;printVarSummary(file_w500->wap(:,0,:,0))



 
   omega500_m_lat(:,:)= tofloat(864.*file_w500->w(:,0,:,0))
 



do j_m=1,month_number
  l_south=0
  l_north=0

  lat_south_2=200.
  lat_north_2=200.

  do j_lat=1,lat_number/3
    if (l_south .eq. 0) then
     if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1) .lt. 0. .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat) .ge. 0.) then
          lat_south=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))*lat(pr_Ii(j_m-1)+j_lat-1) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))*lat(pr_Ii(j_m-1)+j_lat)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))))
          l_south=1
     end if
    end if
    if (l_north .eq. 0) then
     if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1) .lt. 0 .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat) .ge. 0.) then
          lat_north=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))*lat(pr_Ii(j_m-1)-j_lat) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))*lat(pr_Ii(j_m-1)-j_lat+1)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))))
          l_north=1
     end if
    end if
  end do
  ;print(l_north-0)
  ;print(l_south-0)
  
  if (abs(lat(pr_Ii(j_m-1)+j_lat-1)) .lt. 40.) then
    if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1) .lt. 0. .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat) .ge. 0.) then
          lat_south_2=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))*lat(pr_Ii(j_m-1)+j_lat-1) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))*lat(pr_Ii(j_m-1)+j_lat)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))))
     end if
   end if

   if (abs(lat(pr_Ii(j_m-1)-j_lat+1)) .lt. 40.) then
        if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1) .lt. 0 .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat) .ge. 0.) then
          lat_north_2=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))*lat(pr_Ii(j_m-1)-j_lat) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))*lat(pr_Ii(j_m-1)-j_lat+1)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))))
        end if
   end if




  ERA_subs_size_lat(j_m-1)   = (abs(lat_south)+abs(lat_north))
  ;subs_size_lat_2(j_m-1) = (abs(lat_south_2)+abs(lat_north_2))
end do


delete(file_w500)
delete(pr_Ii)
delete(omega500_m_lat)






  ;subs_size_lat = new(month_number,float)
  

  GPCP_pr_Ai        = new(month_number,float)
  GPCP_pr_Ei        = new(month_number,float)

  do j_time=1,month_number
  ;print(j_time-1)
  
  do j_lat=toint(lat_number/3),toint(2*lat_number/3)
   if(lat(j_lat-1) .GE. -index_lat .AND. lat(j_lat-1) .LE. index_lat) then 
    if(lat(j_lat-2) .LT. -index_lat) then
      DN=2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI))+ \
            precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)))/2.     \
           *tofloat((lat(j_lat-1)+ lat(j_lat))/2.+index_lat)/180.*PI
    else
      if(lat(j_lat) .GT. index_lat) then
        DN=DN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                            tofloat(index_lat-(lat(j_lat-1)+ lat(j_lat-2))/2.)/180.*PI
       else
        DN=DN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                    tofloat((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2.)/180.*PI
      end if
    end if
   end if
 end do

 DN = DN/tofloat(2.*PI*(sin(index_lat/180.*PI)-sin(-index_lat/180.*PI)))
 

;------------------------------------------------------------------------------------------
; Asymmetry:

 ;do j_lat=2,lat_number-1
 do j_lat=toint(lat_number/3),toint(2*lat_number/3)
   if(lat(j_lat-1) .GE. -index_lat .AND. lat(j_lat-1) .LE. 0.) then 
    if(lat(j_lat-2) .LT. -index_lat) then
      DN_SH=2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI))+ \
            precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)))/2.     \
           *tofloat((lat(j_lat-1)+ lat(j_lat))/2.+index_lat)/180.*PI
    else
      if(lat(j_lat) .GT. 0.) then
        DN_SH=DN_SH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                            tofloat((lat(j_lat-1)+ lat(j_lat-2))/2.)/180.*PI
       else
        DN_SH=DN_SH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                    tofloat((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2.)/180.*PI
     end if
    end if
   end if

   if(lat(j_lat-1) .GE. 0. .AND. lat(j_lat-1) .LE. index_lat) then
    if(lat(j_lat-2) .LT. 0.) then
      DN_NH=2*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                  precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \         
                 ((lat(j_lat-1)+ lat(j_lat))/2.)/180.*PI
    else
      if(lat(j_lat) .GT. index_lat) then
        DN_NH=DN_NH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                        precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2.   * \
                      (index_lat-(lat(j_lat-1)+ lat(j_lat)-2)/2.)/180.*PI
      else
        DN_NH=DN_NH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                                  precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                     ((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2. )/180.*PI
      end if
    end if 
   end if
  end do

  DN_SH=DN_SH/tofloat(2.*PI*(-sin(-index_lat/180.*PI)))
  DN_NH=DN_NH/tofloat(2.*PI*(sin(index_lat/180.*PI))) 

   GPCP_pr_Ai(j_time-1) = (tofloat((DN_NH-DN_SH)/DN))

;------------------------------------------------------------------------------------------------------------
; Relative Eq. Prec.:

 ;do j_lat=2,lat_number-1
 do j_lat=toint(lat_number/3),toint(2*lat_number/3)
   if(lat(j_lat-1) .GE. -eq_lat .AND. lat(j_lat-1) .LE. eq_lat) then 
    if(lat(j_lat-2) .LT. -eq_lat) then
      EN=2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI))+ \
            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2.     \
           *tofloat((lat(j_lat-1)+ lat(j_lat))/2.+eq_lat)/180.*PI
    else
      if(lat(j_lat) .GT. eq_lat) then
        EN=EN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                            tofloat(eq_lat-(lat(j_lat-1)+ lat(j_lat-2))/2.)/180.*PI
       else
        EN=EN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                    tofloat((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2.)/180.*PI
      end if
    end if
   end if
 end do

 EN = EN/tofloat(2.*PI*(sin(eq_lat/180.*PI)-sin(-eq_lat/180.*PI)))
 ;pr_Ei(j_time-1) = tofloat(EN/DN) -1.
  GPCP_pr_Ei(j_time-1) = tofloat(DN/EN)

 ;pr_Ei_t(j_time-1) = tofloat(DN) 
 ;pr_Ei(j_time-1) = tofloat(EN)



  delete(DN)
  delete(EN)
  delete(DN_SH)
  delete(DN_NH)
 end do

  GPCP_tm_zonvar_eq_precip_m_sym_sel = new((/month_number/),float)
  GPCP_pr_Ei_sym_sel                 = new((/month_number/),float)
  ERA_subs_size_lat_sym_sel         = new((/month_number/),float)
  ERA_subs_frac_tm_sym_sel = new((/month_number/),float)

  do j_m=1,month_number
    if (abs(GPCP_pr_Ai(j_m-1)) .le. 0.4) then
      GPCP_tm_zonvar_eq_precip_m_sym_sel(j_m-1) = GPCP_tm_zonvar_eq_precip_m(j_m-1)
      GPCP_pr_Ei_sym_sel(j_m-1) = GPCP_pr_Ei(j_m-1)
      ERA_subs_size_lat_sym_sel(j_m-1) = ERA_subs_size_lat(j_m-1)
      ERA_subs_frac_tm_sym_sel(j_m-1) = ERA_subs_frac_tm(j_m-1)
    end if
  end do


  delete(precip_mm_o_2)
  delete(precip_mm_o)
  delete(precip_mm)


  
  delete(lat)
  delete(lat_number)
  delete(lon)
  delete(lon_number)

  delete(file1)
  delete(file_m)
  delete(file_w500_hr)


  delete(time)
  delete(time_number)
  delete(utc_date)
  delete(month_change)
  delete(month_days)
  delete(days_since_start)



;=====================================================================================================
;------------------------------------------------------------------------------------------------------
;======================================================================================================

 















;========================================================================================================

;========================================================================================================




do j_f=2,m_number
  ;file1     = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_5S_5N_MERM.nc","r")
  ;file_m    = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_mm_ZM.nc","r")
  ;file_w500 = addfile("../FILES_AMIP/wap500_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_ZM.nc","r")

  file1     = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r") ;precip, daily means, meridional mean from 6S to 6N
  file_m    = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_mm_ZM.nc","r")   ;precip, monthly means, zonal means 

  file_tas     = addfile("../FILES_AMIP/tas/tas_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r") ;surface air temp, daily means, meridional mean from 6S to 6N

  file_w500 = addfile("../FILES_AMIP/wap500_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_ZM.nc","r") ;omega 500, monthly means, zonal means 
  file_w500_hr = addfile("../FILES_AMIP/wap500_day/wap500_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r") ;omega 500, daily means, meridional mean from 6S to 6N

  file_RAD = addfile("../FILES_AMIP/rad/Rad_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_TM.nc","r") ;radiative fluxes (TOA & SURF), mon means, area mean 6S to 6N 

  file_hfss = addfile("../FILES_AMIP/surf_flux/hfss_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_TM.nc","r") ;surface sensible heat flux, mon means, area mean 6S to 6N
  file_hfls = addfile("../FILES_AMIP/surf_flux/hfls_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_TM.nc","r") ;surface latent heat flux, mon means, area mean 6S to 6N


  file_RAD_S = addfile("../FILES_AMIP/rad/Rad_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_16S_10S_TM.nc","r") ;radiative fluxes (TOA & SURF), mon means, area mean 16S to 10S
  file_RAD_N = addfile("../FILES_AMIP/rad/Rad_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_10N_16N_TM.nc","r")  ;radiative fluxes (TOA & SURF), mon means, area mean 10N to 16N

;  file_RAD_S2 = addfile("../FILES_AMIP/rad/RAD_Amon_"+file_names(j_f-1)+"_r128x64_amip_r1i1p1_"+yearmon+"_mm_12S_6S_MEAN.nc","r")
;  file_RAD_N2 = addfile("../FILES_AMIP/rad/RAD_Amon_"+file_names(j_f-1)+"_r128x64_amip_r1i1p1_"+yearmon+"_mm_6N_12N_MEAN.nc","r")

;  file_RAD_S3 = addfile("../FILES_AMIP/rad/RAD_Amon_"+file_names(j_f-1)+"_r128x64_amip_r1i1p1_"+yearmon+"_mm_20S_14S_MEAN.nc","r")
;  file_RAD_N3 = addfile("../FILES_AMIP/rad/RAD_Amon_"+file_names(j_f-1)+"_r128x64_amip_r1i1p1_"+yearmon+"_mm_14N_20N_MEAN.nc","r")
  

  file_hfss_S = addfile("../FILES_AMIP/surf_flux/hfss_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_16S_10S_TM.nc","r") ;surface sensible heat flux, mon means, area mean 16S to 10S
  file_hfls_S = addfile("../FILES_AMIP/surf_flux/hfls_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_16S_10S_TM.nc","r") ;surface latent heat flux, mon means, area mean 16S to 10S

  file_hfss_N = addfile("../FILES_AMIP/surf_flux/hfss_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_10N_16N_TM.nc","r") ;surface sensible heat flux, mon means, area mean 10N to 16N
  file_hfls_N = addfile("../FILES_AMIP/surf_flux/hfls_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_10N_16N_TM.nc","r") ;surface latent heat flux, mon means, area mean 10N to 16N

;  file_hfss_S2 = addfile("../FILES_AMIP/surf_flux/hfss_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_12S_6S_MEAN.nc","r")
;  file_hfls_S2 = addfile("../FILES_AMIP/surf_flux/hfls_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_12S_6S_MEAN.nc","r")

;  file_hfss_N2 = addfile("../FILES_AMIP/surf_flux/hfss_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_6N_12N_MEAN.nc","r")
;  file_hfls_N2 = addfile("../FILES_AMIP/surf_flux/hfls_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_6N_12N_MEAN.nc","r")

;  file_hfss_S3 = addfile("../FILES_AMIP/surf_flux/hfss_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_20S_14S_MEAN.nc","r")
;  file_hfls_S3 = addfile("../FILES_AMIP/surf_flux/hfls_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_20S_14S_MEAN.nc","r")

;  file_hfss_N3 = addfile("../FILES_AMIP/surf_flux/hfss_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_14N_20N_MEAN.nc","r")
;  file_hfls_N3 = addfile("../FILES_AMIP/surf_flux/hfls_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_14N_20N_MEAN.nc","r")


;  file_ta   = addfile("../FILES_AMIP/ta/ta_Amon_"+file_names(j_f-1)+"_r128x64_amip_r1i1p1_"+yearmon+"_5S_5N_MEAN.nc","r")
;  file_ta_S = addfile("../FILES_AMIP/ta/ta_Amon_"+file_names(j_f-1)+"_r128x64_amip_r1i1p1_"+yearmon+"_16S_10S_MEAN.nc","r")
;  file_ta_N = addfile("../FILES_AMIP/ta/ta_Amon_"+file_names(j_f-1)+"_r128x64_amip_r1i1p1_"+yearmon+"_10N_16N_MEAN.nc","r")


file_ta   = addfile("../FILES_AMIP/ta/ta_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_MEAN.nc","r")  ;atm temperature, mon means, area mean 6S to 6N
file_hus  = addfile("../FILES_AMIP/hus/hus_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_MEAN.nc","r") ;atm specific humidity, mon means, area mean 6S to 6N
file_zg   = addfile("../FILES_AMIP/zg/zg_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_MEAN.nc","r")   ; Geop. height, mon means, area mean 6S to 6N

file_ta_S   = addfile("../FILES_AMIP/ta/ta_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_16S_10S_MEAN.nc","r") ; atm temperature, mon means, area mean 16S to 10S
file_hus_S  = addfile("../FILES_AMIP/hus/hus_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_16S_10S_MEAN.nc","r") ;atm specific humidity, mon means, area mean 16S to 10S
file_zg_S   = addfile("../FILES_AMIP/zg/zg_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_16S_10S_MEAN.nc","r") ; Geop. height, mon means, area mean 16S to 10S

file_ta_N   = addfile("../FILES_AMIP/ta/ta_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_10N_16N_MEAN.nc","r") ; atm temperature, mon means, area mean 10N to 16N
file_hus_N  = addfile("../FILES_AMIP/hus/hus_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_10N_16N_MEAN.nc","r") ;atm specific humidity, mon means, area mean 10N to 16N
file_zg_N   = addfile("../FILES_AMIP/zg/zg_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_10N_16N_MEAN.nc","r") ; Geop. height, mon means, area mean 10N to 16N



  file_ts   = addfile("../FILES_AMIP/ts/ts_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_MEAN.nc","r")   ; surface temperature, mon means, area mean 6S to 6N
  file_ts_S = addfile("../FILES_AMIP/ts/ts_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_16S_10S_MEAN.nc","r") ; surface temperature, mon means, area mean 16S to 10S
  file_ts_N = addfile("../FILES_AMIP/ts/ts_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_10N_16N_MEAN.nc","r") ; surface temperature, mon means, area mean 10N to 16N

  file_ts_MERM   = addfile("../FILES_AMIP/ts/ts_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_MERM.nc","r") ; surface temperature, mon means, meridional mean from 6S to 6N

;  file_va  = addfile("../FILES_AMIP/va/va_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_5S_5N_MEAN.nc","r")
  file_wap = addfile("../FILES_AMIP/wap/wap_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_6S_6N_MEAN.nc","r") ; omega, mon means, area mean 6S to 6N
 



  lat=file_m->lat
  lat_number=dimsizes(lat)
 
  lon = file1->lon
  lon_number = dimsizes(lon)


  lev=tofloat(file_wap->plev)
  lev_number=dimsizes(lev)


  m_days=31

;=================================================


 time = file1->time
 time_number=dimsizes(time)

 utc_date =cd_calendar(time,0)
 time_counter=1
 month_change=new(time_number,float)
 month_change(:)=0.
 do j_time=2,time_number-1
   if(utc_date(j_time-1,1) .NE. utc_date(j_time-2,1)) then
     time_counter=time_counter+1
    month_change(j_time-1)=1.
   end if
 end do

month_days=new(time_counter,integer)

m_counter=0
j_month=0
do j_time=1,time_number
 if (month_change(j_time-1) .eq. 1.) then
   month_days(j_month) = m_counter
   j_month= j_month + 1 
   m_counter=1
 else 
   m_counter=m_counter+1
 end if
end do
month_days(time_counter-1) =m_counter


 days_since_start= new(time_counter,integer)
 days_since_start(0)=0
 do j_m=2,time_counter
   days_since_start(j_m-1)= days_since_start(j_m-2)+month_days(j_m-2)
 end do


 month_number=time_counter
;===================================================




;  printVarSummary(file1->pr)

  precip_hr_eq = new ((/time_number,lon_number/),float)
  precip_hr_eq(:,:) = file1->pr(:,0,:)

  tas_hr_eq = new ((/time_number,lon_number/),float)
  tas_hr_eq(:,:) = file_tas->tas(:,0,:)


   precip_mm     = new((/month_number,lat_number/),float)
   precip_mm_o   = new((/month_number,lat_number/),float)
   precip_mm_o_2 = new((/month_number,lat_number/),float)

   ;printVarSummary(precip_mm)
   ;printVarSummary(file_m->pr)

   do j_m=1,month_number
     precip_mm(j_m-1,:) = 86400.*file_m->pr(j_m-1,:,0)
     ;precip_mm_o(j_m-1,:) = 86400.*file_m->pr(j_m-1,:,0)
     ;precip_mm_o_2(j_m-1,:) = wgt_runave_n(precip_mm_o(j_m-1,:),(/0.2,0.6,0.2/),0,0)
     ;precip_mm(j_m-1,:) = wgt_runave_n(precip_mm_o_2(j_m-1,:),(/0.2,0.6,0.2/),0,0)
   end do


  zonvar_eq_precip = new (time_number,float)
  zonavg_eq_precip = new (time_number,float)

  zonvar_eq_precip_m = new ((/month_number,m_days/),float)
  zonavg_eq_precip_m = new ((/month_number,m_days/),float)

  tm_zonvar_eq_precip_m = new (month_number,float)
  tm_zonavg_eq_precip_m = new (month_number,float)


  zonvar_eq_tas = new (time_number,float)
  zonavg_eq_tas = new (time_number,float)

  zonvar_eq_tas_m = new ((/month_number,m_days/),float)
  zonavg_eq_tas_m = new ((/month_number,m_days/),float)

  tm_zonvar_eq_tas_m = new (month_number,float)
  tm_zonavg_eq_tas_m = new (month_number,float)


  do j_t=1,time_number
      ;print(j_t-1)
      zonavg_eq_precip(j_t-1) = avg(precip_hr_eq(j_t-1,:))
      zonavg_eq_tas(j_t-1) = avg(tas_hr_eq(j_t-1,:))
      zonvar_eq_precip(j_t-1)  = sqrt(sum((precip_hr_eq(j_t-1,:) - zonavg_eq_precip(j_t-1))^2) /lon_number) /zonavg_eq_precip(j_t-1)
      zonvar_eq_tas(j_t-1)  = sqrt(sum((tas_hr_eq(j_t-1,:) - zonavg_eq_tas(j_t-1))^2) /lon_number)
  end do

  
  do j_m=1,month_number
    ;print(j_m-1)
    ;print(days_since_start(j_m-1))
    ;print(days_since_start(j_m-1)+m_days-1)
    m_days=month_days(j_m-1)
    zonavg_eq_precip_m(j_m-1,0:(m_days-1)) = zonavg_eq_precip(days_since_start(j_m-1):(days_since_start(j_m-1)+m_days-1))
    zonvar_eq_precip_m(j_m-1,0:(m_days-1)) = zonvar_eq_precip(days_since_start(j_m-1):(days_since_start(j_m-1)+m_days-1))

    tm_zonvar_eq_precip_m(j_m-1) = avg(zonvar_eq_precip_m(j_m-1,:))
    tm_zonavg_eq_precip_m(j_m-1) = avg(zonavg_eq_precip_m(j_m-1,:))

    zonvar_eq_tas_m(j_m-1,0:(m_days-1)) = zonvar_eq_tas(days_since_start(j_m-1):(days_since_start(j_m-1)+m_days-1))
    tm_zonvar_eq_tas_m(j_m-1) = avg(zonvar_eq_tas_m(j_m-1,:))
  end do


  m_days=31

;=====================================================================================================
;------------------------------------------------------------------------------------------------------
;======================================================================================================

  delete(zonvar_eq_precip_m)
  delete(zonavg_eq_precip_m)

  delete(zonvar_eq_precip)
  delete(zonavg_eq_precip)

  delete(zonvar_eq_tas_m)
  delete(zonavg_eq_tas_m)

  delete(zonvar_eq_tas)
  delete(zonavg_eq_tas)

  delete(precip_hr_eq)
  delete(tas_hr_eq)
  




  MSE_850 = new(month_number,float)
  MSE_850_S = new(month_number,float)
  MSE_850_N = new(month_number,float)  



  MSE_850(:)   = c_p*file_ta->ta(:,2,0,0)   + L_v*file_hus->hus(:,2,0,0)   + grav*file_zg->zg(:,2,0,0)

  MSE_850_S(:) = c_p*file_ta_S->ta(:,2,0,0) + L_v*file_hus_S->hus(:,2,0,0) + grav*file_zg_S->zg(:,2,0,0)

  MSE_850_N(:) = c_p*file_ta_N->ta(:,2,0,0) + L_v*file_hus_N->hus(:,2,0,0) + grav*file_zg_N->zg(:,2,0,0)

  


  pr_Ii        = new(month_number,integer)

 

  do j_lat=toint(lat_number/3),toint(2*lat_number/3)
    if(lat(j_lat-1) .GE. -crit_lat .AND. lat(j_lat-2) .LT. -crit_lat) then 
      c_ST = j_lat-1
    end if
    if(lat(j_lat) .GE. crit_lat .AND. lat(j_lat-1) .LT. crit_lat) then 
      c_NT = j_lat-1
    end if
  end do

  do j_time=1,month_number
    pr_Ii(j_time-1) = c_ST + maxind(precip_mm(j_time-1,c_ST:c_NT))
  end do

  delete(c_ST)
  delete(c_NT)




 omega500_m_lat = new ((/month_number,lat_number/),float)
 subs_size_lat = new ((/month_number/),float)

 omega500_hr_eq = new ((/time_number,lon_number/),float)
 ;printVarSummary(omega500_m_lat)
 ;printVarSummary(file_w500->wap(:,0,:,0))


 ;print(j_f)
 ;print("../FILES_AMIP/wap500_day/wap500_day_"+file_names(0)+"_r128x64_amip_r1i1p1_"+yearmonday+"_5S_5N_MERM.nc")
 ;printVarSummary(file_w500_hr->wap)
 if (j_f .eq. 1) then
   ;printVarSummary(file_w500->w(:,0,:,0))
   ;printVarSummary(omega500_m_lat) 
   omega500_m_lat(:,:)= tofloat(864.*file_w500->w(:,0,:,0))
   omega500_hr_eq(:,:) = tofloat(864.*file_w500_hr->w(:,0,0,:))
 else
   omega500_m_lat(:,:)= 864.*file_w500->wap(:,0,:,0)
   omega500_hr_eq(:,:) = 864.*file_w500_hr->wap(:,0,0,:)
 end if
; printVarSummary(lat)
; printVarSummary(omega500_m_lat)




  ;Subsidence fraction
  subs_frac_tm   = new (month_number,float)
  ;subs_frac_tm_d = new ((/file_number,file_number/),float)
  do j_m=1,month_number
    m_days=month_days(j_m-1)
    subs_frac=new(m_days,float)
    do j_t=1,m_days
      omeg_counter=0.
        do j_lon=1,lon_number
          if ( omega500_hr_eq(days_since_start(j_m-1)+j_t-1,j_lon-1) .lt. 0.) then 
            omeg_counter = omeg_counter + 1.
          end if
        end do
      subs_frac(j_t-1) = (tofloat(lon_number)-omeg_counter)/tofloat(lon_number)
    end do
    subs_frac_tm(j_m-1)         = avg(subs_frac(:))
    ;subs_frac_tm_d(j_m-1,j_m-1) = avg(subs_frac(:))
    delete(subs_frac)
  end do

  delete(omega500_hr_eq)












do j_m=1,month_number
  l_south=0
  l_north=0

  lat_south_2=200.
  lat_north_2=200.

  do j_lat=1,lat_number/3
    if (l_south .eq. 0) then
     if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1) .lt. 0. .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat) .ge. 0.) then
          lat_south=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))*lat(pr_Ii(j_m-1)+j_lat-1) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))*lat(pr_Ii(j_m-1)+j_lat)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))))
          l_south=1
     end if
    end if
    if (l_north .eq. 0) then
     if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1) .lt. 0 .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat) .ge. 0.) then
          lat_north=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))*lat(pr_Ii(j_m-1)-j_lat) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))*lat(pr_Ii(j_m-1)-j_lat+1)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))))
          l_north=1
     end if
    end if
  end do
  ;print(l_north-0)
  ;print(l_south-0)
  
  if (abs(lat(pr_Ii(j_m-1)+j_lat-1)) .lt. 40.) then
    if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1) .lt. 0. .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat) .ge. 0.) then
          lat_south_2=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))*lat(pr_Ii(j_m-1)+j_lat-1) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))*lat(pr_Ii(j_m-1)+j_lat)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)+j_lat-1))))
     end if
   end if

   if (abs(lat(pr_Ii(j_m-1)-j_lat+1)) .lt. 40.) then
        if (omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1) .lt. 0 .and. omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat) .ge. 0.) then
          lat_north_2=   doubletofloat((abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))*lat(pr_Ii(j_m-1)-j_lat) + abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))*lat(pr_Ii(j_m-1)-j_lat+1)) / \
                       (abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat+1))+abs(omega500_m_lat(j_m-1,pr_Ii(j_m-1)-j_lat))))
        end if
   end if




  subs_size_lat(j_m-1)   = (abs(lat_south)+abs(lat_north))
  ;subs_size_lat_2(j_m-1) = (abs(lat_south_2)+abs(lat_north_2))
end do


delete(file_w500)
delete(file_w500_hr)
delete(pr_Ii)
delete(omega500_m_lat)





  ;subs_size_lat = new(month_number,float)
  

  pr_Ai        = new(month_number,float)
  pr_Ei        = new(month_number,float)

  do j_time=1,month_number
  ;print(j_time-1)
  
  do j_lat=toint(lat_number/3),toint(2*lat_number/3)
   if(lat(j_lat-1) .GE. -index_lat .AND. lat(j_lat-1) .LE. index_lat) then 
    if(lat(j_lat-2) .LT. -index_lat) then
      DN=2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI))+ \
            precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)))/2.     \
           *tofloat((lat(j_lat-1)+ lat(j_lat))/2.+index_lat)/180.*PI
    else
      if(lat(j_lat) .GT. index_lat) then
        DN=DN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                            tofloat(index_lat-(lat(j_lat-1)+ lat(j_lat-2))/2.)/180.*PI
       else
        DN=DN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                    tofloat((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2.)/180.*PI
      end if
    end if
   end if
 end do

 DN = DN/tofloat(2.*PI*(sin(index_lat/180.*PI)-sin(-index_lat/180.*PI)))
 

;------------------------------------------------------------------------------------------
; Asymmetry:

 ;do j_lat=2,lat_number-1
 do j_lat=toint(lat_number/3),toint(2*lat_number/3)
   if(lat(j_lat-1) .GE. -index_lat .AND. lat(j_lat-1) .LE. 0.) then 
    if(lat(j_lat-2) .LT. -index_lat) then
      DN_SH=2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI))+ \
            precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)))/2.     \
           *tofloat((lat(j_lat-1)+ lat(j_lat))/2.+index_lat)/180.*PI
    else
      if(lat(j_lat) .GT. 0.) then
        DN_SH=DN_SH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                            tofloat((lat(j_lat-1)+ lat(j_lat-2))/2.)/180.*PI
       else
        DN_SH=DN_SH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                    tofloat((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2.)/180.*PI
     end if
    end if
   end if

   if(lat(j_lat-1) .GE. 0. .AND. lat(j_lat-1) .LE. index_lat) then
    if(lat(j_lat-2) .LT. 0.) then
      DN_NH=2*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                  precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \         
                 ((lat(j_lat-1)+ lat(j_lat))/2.)/180.*PI
    else
      if(lat(j_lat) .GT. index_lat) then
        DN_NH=DN_NH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                        precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2.   * \
                      (index_lat-(lat(j_lat-1)+ lat(j_lat)-2)/2.)/180.*PI
      else
        DN_NH=DN_NH+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                                  precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                     ((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2. )/180.*PI
      end if
    end if 
   end if
  end do

  DN_SH=DN_SH/tofloat(2.*PI*(-sin(-index_lat/180.*PI)))
  DN_NH=DN_NH/tofloat(2.*PI*(sin(index_lat/180.*PI))) 

   pr_Ai(j_time-1) = (tofloat((DN_NH-DN_SH)/DN))

;------------------------------------------------------------------------------------------------------------
; Relative Eq. Prec.:

 ;do j_lat=2,lat_number-1
 do j_lat=toint(lat_number/3),toint(2*lat_number/3)
   if(lat(j_lat-1) .GE. -eq_lat .AND. lat(j_lat-1) .LE. eq_lat) then 
    if(lat(j_lat-2) .LT. -eq_lat) then
      EN=2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI))+ \
            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2.     \
           *tofloat((lat(j_lat-1)+ lat(j_lat))/2.+eq_lat)/180.*PI
    else
      if(lat(j_lat) .GT. eq_lat) then
        EN=EN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                            tofloat(eq_lat-(lat(j_lat-1)+ lat(j_lat-2))/2.)/180.*PI
       else
        EN=EN+2.*PI*(precip_mm(j_time-1,j_lat-1)*tofloat(cos(lat(j_lat-1)/180.*PI)) + \
                            precip_mm(j_time-1,j_lat)*tofloat(cos(lat(j_lat)/180.*PI)))/2. * \
                    tofloat((lat(j_lat-1)+ lat(j_lat))/2.-(lat(j_lat-2)+ lat(j_lat-1))/2.)/180.*PI
      end if
    end if
   end if
 end do

 EN = EN/tofloat(2.*PI*(sin(eq_lat/180.*PI)-sin(-eq_lat/180.*PI)))
 ;pr_Ei(j_time-1) = tofloat(EN/DN) -1.
  pr_Ei(j_time-1) = tofloat(DN/EN)

 ;pr_Ei_t(j_time-1) = tofloat(DN) 
 ;pr_Ei(j_time-1) = tofloat(EN)



  delete(DN)
  delete(EN)
  delete(DN_SH)
  delete(DN_NH)
 end do




;=============================================================================================
;Radiative tendencies:

 TOT_rad = new (month_number,float)
 ACRE    = new (month_number,float)
 UPTAKE  = new (month_number,float)
 TURB    = new (month_number,float)

 TOT_rad(:) = file_RAD->rlus(:,0,0)-file_RAD->rlds(:,0,0)-file_RAD->rlut(:,0,0) \
             -file_RAD->rsds(:,0,0)+file_RAD->rsdt(:,0,0)+file_RAD->rsus(:,0,0) - file_RAD->rsut(:,0,0)

 ACRE(:) =   -file_RAD->rlds(:,0,0)-file_RAD->rlut(:,0,0) \
             -file_RAD->rsds(:,0,0)+file_RAD->rsus(:,0,0)- file_RAD->rsut(:,0,0) \
             +file_RAD->rldscs(:,0,0)+file_RAD->rlutcs(:,0,0)+file_RAD->rsdscs(:,0,0) \
             -file_RAD->rsuscs(:,0,0) + file_RAD->rsutcs(:,0,0)

 UPTAKE(:) = TOT_rad(:) + file_hfss->hfss(:,0,0) + file_hfls->hfls(:,0,0)
 TURB(:)   = file_hfss->hfss(:,0,0) + file_hfls->hfls(:,0,0)


 TOT_rad_a = new (month_number,float)
 ACRE_a    = new (month_number,float)
 UPTAKE_a   = new (month_number,float)
;
; UPTAKE_b   = new (month_number,float)
;
; UPTAKE_c   = new (month_number,float)

 TOT_rad_a(:) = (file_RAD_S->rlus(:,0,0)-file_RAD_S->rlds(:,0,0)-file_RAD_S->rlut(:,0,0) \
             -file_RAD_S->rsds(:,0,0)+file_RAD_S->rsdt(:,0,0)+file_RAD_S->rsus(:,0,0) - file_RAD_S->rsut(:,0,0) \
              + file_RAD_N->rlus(:,0,0)-file_RAD_N->rlds(:,0,0)-file_RAD_N->rlut(:,0,0) \
             -file_RAD_N->rsds(:,0,0)+file_RAD_N->rsdt(:,0,0)+file_RAD_N->rsus(:,0,0) - file_RAD_N->rsut(:,0,0))/2.

 ACRE_a(:) = (  -file_RAD_S->rlds(:,0,0)-file_RAD_S->rlut(:,0,0) \
             -file_RAD_S->rsds(:,0,0)+file_RAD_S->rsus(:,0,0)- file_RAD_S->rsut(:,0,0) \
             +file_RAD_S->rldscs(:,0,0)+file_RAD_S->rlutcs(:,0,0)+file_RAD_S->rsdscs(:,0,0) \
             -file_RAD_S->rsuscs(:,0,0) + file_RAD_S->rsutcs(:,0,0) \
             -file_RAD_N->rlds(:,0,0)-file_RAD_N->rlut(:,0,0) \
             -file_RAD_N->rsds(:,0,0)+file_RAD_N->rsus(:,0,0)- file_RAD_N->rsut(:,0,0) \
             +file_RAD_N->rldscs(:,0,0)+file_RAD_N->rlutcs(:,0,0)+file_RAD_N->rsdscs(:,0,0) \
             -file_RAD_N->rsuscs(:,0,0) + file_RAD_N->rsutcs(:,0,0))/2.


 

 UPTAKE_a(:) = TOT_rad_a(:) + (file_hfss_S->hfss(:,0,0) + file_hfls_S->hfls(:,0,0) + \
                               file_hfss_N->hfss(:,0,0) + file_hfls_N->hfls(:,0,0))/2.

; UPTAKE_a(:) = UPTAKE(:) - (TOT_rad_a(:) + (file_hfss_S->hfss(:,0,0) + file_hfls_S->hfls(:,0,0) + \
;                               file_hfss_N->hfss(:,0,0) + file_hfls_N->hfls(:,0,0))/2.)

 ;UPTAKE_b(:) = (file_RAD_S2->rlus(:,0,0)-file_RAD_S2->rlds(:,0,0)-file_RAD_S2->rlut(:,0,0) \
 ;            -file_RAD_S2->rsds(:,0,0)+file_RAD_S2->rsdt(:,0,0)+file_RAD_S2->rsus(:,0,0) - file_RAD_S2->rsut(:,0,0) \
 ;             + file_RAD_N2->rlus(:,0,0)-file_RAD_N2->rlds(:,0,0)-file_RAD_N2->rlut(:,0,0) \
 ;            -file_RAD_N2->rsds(:,0,0)+file_RAD_N2->rsdt(:,0,0)+file_RAD_N2->rsus(:,0,0) - file_RAD_N2->rsut(:,0,0))/2. \ 
 ;            + (file_hfss_S2->hfss(:,0,0) + file_hfls_S2->hfls(:,0,0) + \
 ;                              file_hfss_N2->hfss(:,0,0) + file_hfls_N2->hfls(:,0,0))/2. 

; UPTAKE_b(:) = UPTAKE(:) - ((file_RAD_S2->rlus(:,0,0)-file_RAD_S2->rlds(:,0,0)-file_RAD_S2->rlut(:,0,0) \
;             -file_RAD_S2->rsds(:,0,0)+file_RAD_S2->rsdt(:,0,0)+file_RAD_S2->rsus(:,0,0) - file_RAD_S2->rsut(:,0,0) \
;              + file_RAD_N2->rlus(:,0,0)-file_RAD_N2->rlds(:,0,0)-file_RAD_N2->rlut(:,0,0) \
;             -file_RAD_N2->rsds(:,0,0)+file_RAD_N2->rsdt(:,0,0)+file_RAD_N2->rsus(:,0,0) - file_RAD_N2->rsut(:,0,0))/2. \ 
;             + (file_hfss_S2->hfss(:,0,0) + file_hfls_S2->hfls(:,0,0) + \
;                               file_hfss_N2->hfss(:,0,0) + file_hfls_N2->hfls(:,0,0))/2. )

 ;UPTAKE_c(:) = (file_RAD_S3->rlus(:,0,0)-file_RAD_S3->rlds(:,0,0)-file_RAD_S3->rlut(:,0,0) \
 ;            -file_RAD_S3->rsds(:,0,0)+file_RAD_S3->rsdt(:,0,0)+file_RAD_S3->rsus(:,0,0) - file_RAD_S3->rsut(:,0,0) \
 ;             + file_RAD_N3->rlus(:,0,0)-file_RAD_N3->rlds(:,0,0)-file_RAD_N3->rlut(:,0,0) \
 ;            -file_RAD_N3->rsds(:,0,0)+file_RAD_N3->rsdt(:,0,0)+file_RAD_N3->rsus(:,0,0) - file_RAD_N3->rsut(:,0,0))/2. \ 
 ;            + (file_hfss_S3->hfss(:,0,0) + file_hfls_S3->hfls(:,0,0) + \
 ;                              file_hfss_N3->hfss(:,0,0) + file_hfls_N3->hfls(:,0,0))/2. 

; UPTAKE_c(:) = UPTAKE(:) - ((file_RAD_S3->rlus(:,0,0)-file_RAD_S3->rlds(:,0,0)-file_RAD_S3->rlut(:,0,0) \
;             -file_RAD_S3->rsds(:,0,0)+file_RAD_S3->rsdt(:,0,0)+file_RAD_S3->rsus(:,0,0) - file_RAD_S3->rsut(:,0,0) \
;              + file_RAD_N3->rlus(:,0,0)-file_RAD_N3->rlds(:,0,0)-file_RAD_N3->rlut(:,0,0) \
;             -file_RAD_N3->rsds(:,0,0)+file_RAD_N3->rsdt(:,0,0)+file_RAD_N3->rsus(:,0,0) - file_RAD_N3->rsut(:,0,0))/2. \ 
;             + (file_hfss_S3->hfss(:,0,0) + file_hfls_S3->hfls(:,0,0) + \
;                               file_hfss_N3->hfss(:,0,0) + file_hfls_N3->hfls(:,0,0))/2.) 


;dphi_T1000 = new (month_number,float)

;dphi_T1000(:)= file_ta->ta(:,0,0,0)-(file_ta_S->ta(:,0,0,0)+file_ta_N->ta(:,0,0,0))/2.


dphi_Ts  = new (month_number,float)
dphi_MSE = new (month_number,float)

dphi_Ts(:)= file_ts->ts(:,0,0)-(file_ts_S->ts(:,0,0)+file_ts_N->ts(:,0,0))/2.
dphi_MSE(:)=MSE_850(:)-(MSE_850_S(:)+MSE_850_N(:))/2. 
;dphi_Ts(:)= abs(file_ts_S->ts(:,0,0)-file_ts_N->ts(:,0,0))



;do j_t=1,month_number
; if (file_ts_N->ts(j_t-1,0,0) .gt. file_ts_S->ts(j_t-1,0,0)) then
;    if (file_ts_N->ts(j_t-1,0,0) .gt. file_ts->ts(j_t-1,0,0)) then 
;      dphi_Ts(j_t-1)=file_ts->ts(j_t-1,0,0) - file_ts_N->ts(j_t-1,0,0)
;    else
;      dphi_Ts(j_t-1)=file_ts->ts(j_t-1,0,0) - file_ts_S->ts(j_t-1,0,0)
;    end if
; else
;    if (file_ts_S->ts(j_t-1,0,0) .gt. file_ts->ts(j_t-1,0,0)) then 
;      dphi_Ts(j_t-1)=file_ts->ts(j_t-1,0,0) - file_ts_S->ts(j_t-1,0,0)
;    else
;      dphi_Ts(j_t-1)=file_ts->ts(j_t-1,0,0) - file_ts_N->ts(j_t-1,0,0)
;    end if
; end if
;end do
;print(dphi_Ts(0:11))

Ts =  new (month_number,float)
Ts(:) = file_ts->ts(:,0,0)


time_vec=new(month_number,float)
do j_t=1,month_number
 time_vec(j_t-1)=tofloat(j_t)
end do

reg_E=regline(time_vec(:),Ts(:))
;reg_E=regline(Ts(:),time_vec(:))
Ts_nt =  new (month_number,float)
Ts_nt(:) = Ts(:) -reg_E*time_vec(:)



Ts_std = new(month_number,float)

do j_t=1,month_number
 Ts_std(j_t-1)= stddev(file_ts_MERM->ts(j_t-1,0,:))
end do



print(reg_E*time_vec(month_number-1))

;Ts(:) = Ts_nt(:)

delete(reg_E)

cen_pres  = new ((/month_number/),float)
omega_int = new ((/month_number/),float)
half_pres = new ((/month_number/),float)
half_pres2 = new ((/month_number/),float)
half_pres_up = new ((/month_number/),float)
half_pres_down = new ((/month_number/),float)
top_index = new ((/month_number/),float)
shallow   = new ((/month_number/),float)

omega_int(:)=0.


;print(lev)
div_lev  = 50000.
div_lev2 = 80000.

do j_lev=2,lev_number-1
 omega_int(:) = omega_int(:)+abs(file_wap->wap(:,j_lev-1,0,0)*(lev(j_lev)-lev(j_lev-2))) 
end do

omega_half_int= new ((/month_number,lev_number/),float)
omega_half_int(:,0) =0.

logical_test= new ((/month_number/),float)
logical_test(:) =0. 

do j_m=1,month_number
  do j_lev=2,lev_number-1
    if (lev(j_lev) .le. div_lev .and. lev(j_lev-1) .gt. div_lev) then
      half_pres(j_m-1) = omega_half_int(j_m-1,j_lev-2)+abs(file_wap->wap(j_m-1,j_lev-1,0,0)*(div_lev-lev(j_lev-1)))
      half_pres_up(j_m-1) =  file_wap->wap(j_m-1,j_lev-1,0,0)
      logical_test(:) =1.
    end if
    if (lev(j_lev) .le. div_lev2 .and. lev(j_lev-1) .gt. div_lev2) then
      half_pres2(j_m-1) = omega_half_int(j_m-1,j_lev-2)+abs(file_wap->wap(j_m-1,j_lev-1,0,0)*(div_lev-lev(j_lev-1)))
      half_pres_down(j_m-1) =  file_wap->wap(j_m-1,j_lev-1,0,0)
      
    end if
    omega_half_int(j_m-1,j_lev-1) = omega_half_int(j_m-1,j_lev-2)+abs(file_wap->wap(j_m-1,j_lev-1,0,0)*(lev(j_lev)-lev(j_lev-2))) 
    if (omega_half_int(j_m-1,j_lev-1) .ge. 0.5*omega_int(j_m-1) .and. omega_half_int(j_m-1,j_lev-2) .lt. 0.5*omega_int(j_m-1)) then
      cen_pres(j_m-1) = (lev(j_lev-1)*(omega_int(j_m-1)/2.-omega_half_int(j_m-1,j_lev-2))+lev(j_lev-2)*(omega_half_int(j_m-1,j_lev-1)-omega_int(j_m-1)/2.)) / \
                      (omega_half_int(j_m-1,j_lev-1)-omega_half_int(j_m-1,j_lev-2))
    end if 
  end do
end do

;top_index(:) = (abs(omega_int(:))-abs(half_pres(:))) / abs(omega_int(:))
top_index(:) = (omega_int(:)-half_pres(:))/omega_int(:)
do j_m=1,month_number
  if(top_index(j_m-1) .lt. 0. .or. top_index(j_m-1) .lt. 0.) then
    print("------ERROR in calculating top-heavyness -----------")
    print(j_m-0)
    print(top_index(j_m-1)-0)
    print(logical_test(j_m-1)-1.)
    print(omega_int(j_m-1)-0.)
    print(half_pres(j_m-1)-0.)
  end if
end do

;shallow(:) = (half_pres2(:)-half_pres(:)) / omega_int(:) 
shallow(:) = 86400.*(half_pres_up(:)-half_pres_down(:))


delete(omega_half_int)
delete(omega_int)
delete(half_pres)
delete(half_pres2)
delete(half_pres_up)
delete(half_pres_down)



;=====================================================================================================
;------------------------------------------------------------------------------------------------------
;======================================================================================================

  tm_zonvar_eq_precip_m_sym_sel = new((/month_number/),float)
  tm_zonvar_eq_tas_m_sym_sel    = new((/month_number/),float)
  pr_Ei_sym_sel                 = new((/month_number/),float)
  subs_size_lat_sym_sel         = new((/month_number/),float)
  subs_frac_tm_sym_sel          = new((/month_number/),float)

  ACRE_sym_sel        = new((/month_number/),float)
  TOT_rad_sym_sel     = new((/month_number/),float)
  UPTAKE_sym_sel      = new((/month_number/),float) 
  TURB_sym_sel        = new((/month_number/),float) 

;  ACRE_a_sym_sel          = new((/month_number/),float)
;  TOT_rad_a_sym_sel       = new((/month_number/),float)
  UPTAKE_a_sym_sel        = new((/month_number/),float) 
;
;  UPTAKE_b_sym_sel        = new((/month_number/),float) 
;
;  UPTAKE_c_sym_sel        = new((/month_number/),float) 
;
;  dphi_T1000_sym_sel = new((/month_number/),float) 
  dphi_Ts_sym_sel     = new((/month_number/),float) 
  dphi_MSE_sym_sel    = new((/month_number/),float)

  Ts_sym_sel          = new((/month_number/),float) 
  Ts_nt_sym_sel       = new((/month_number/),float) 
  Ts_std_sym_sel      = new((/month_number/),float) 

  MSE_850_sym_sel          = new((/month_number/),float)  
  

  cen_pres_sym_sel    = new((/month_number/),float) 

  top_index_sym_sel    = new((/month_number/),float) 

  month_number_sym=0.

  do j_m=1,month_number
    if (abs(pr_Ai(j_m-1)) .le. 0.4) then
      tm_zonvar_eq_precip_m_sym_sel(j_m-1) = tm_zonvar_eq_precip_m(j_m-1)
      tm_zonvar_eq_tas_m_sym_sel(j_m-1)    = tm_zonvar_eq_tas_m(j_m-1)
      pr_Ei_sym_sel(j_m-1) = pr_Ei(j_m-1)
      subs_size_lat_sym_sel(j_m-1) = subs_size_lat(j_m-1)
      subs_frac_tm_sym_sel(j_m-1)  = subs_frac_tm(j_m-1)
      ACRE_sym_sel(j_m-1)          = ACRE(j_m-1)
      TOT_rad_sym_sel(j_m-1)       = TOT_rad(j_m-1)
      UPTAKE_sym_sel(j_m-1)        = UPTAKE(j_m-1)
      TURB_sym_sel(j_m-1)          = TURB(j_m-1)
;      ACRE_a_sym_sel(j_m-1)        = ACRE_a(j_m-1)
;      TOT_rad_a_sym_sel(j_m-1)     = TOT_rad_a(j_m-1)
      UPTAKE_a_sym_sel(j_m-1)      = UPTAKE_a(j_m-1)
;      UPTAKE_b_sym_sel(j_m-1)      = UPTAKE_b(j_m-1)
;      UPTAKE_c_sym_sel(j_m-1)      = UPTAKE_c(j_m-1)
;
;      dphi_T1000_sym_sel(j_m-1) = dphi_T1000(j_m-1)
      dphi_Ts_sym_sel(j_m-1)     = dphi_Ts(j_m-1)
      dphi_MSE_sym_sel(j_m-1)    = dphi_MSE(j_m-1)
      Ts_sym_sel(j_m-1)          = Ts(j_m-1)
      Ts_nt_sym_sel(j_m-1)       = Ts_nt(j_m-1)
      Ts_std_sym_sel(j_m-1)      = Ts_std(j_m-1)

      MSE_850_sym_sel(j_m-1)     = MSE_850(j_m-1)
;
      cen_pres_sym_sel(j_m-1)  = cen_pres(j_m-1)

      top_index_sym_sel(j_m-1) = top_index(j_m-1)
      
      if (abs(GPCP_pr_Ai(j_m-1)) .le. 0.4) then
        month_number_sym=month_number_sym+1.
      end if
    end if
  end do


  ;print("j_f= "+j_f)
  print("  ")
  print("  ")
  print(file_names(j_f-1)+":")
  print("  ")
 ; print("Min Value clustering:")
 ; print(min(tm_zonvar_eq_precip_m(:)))
 ; print("Max Value clustering:")
 ; print(max(tm_zonvar_eq_precip_m(:)))
 ; print("  ")
 ; print("Min Value Width (precip):")
 ; print(min(pr_Ei(:)))
 ; print("Max Value Width (precip):")
 ; print(max(pr_Ei(:)))
 ; print("  ")
 ; print("Min Value Width (dyn):")
 ; print(min(subs_size_lat(:)))
 ; print("Max Value Width (dyn):")
 ; print(max(subs_size_lat(:)))
 ; print("  ")  


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = subs_frac_tm(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),subs_frac_tm(:))

  reg_line_cl_width(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ; print("Cor: std precip - subs frac")
  ; print((corr_EDIV(1))^2)
  ; print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ; print("Regression coefficient: ")
  ; print(reg_E-0.)
  ; print("  ") 
 

  delete(corr_EDIV)
  delete(corr_mat_E) 



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),pr_Ei(:))

  reg_line_cl_width(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ; print("Cor: std precip - Width (precip)")
  ; print((corr_EDIV(1))^2)
  ; print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ; print("Regression coefficient: ")
  ; print(reg_E-0.)
  ; print("  ") 

  corr_cl_width(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = subs_size_lat(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),subs_size_lat(:))

  reg_line_cl_ssl(j_f-1) = reg_E


   corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ; print("Cor: std precip - Width (dyn)")
  ; print((corr_EDIV(1))^2)
  ; print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ; print("Regression coefficient: ")
  ; print(reg_E-0.)

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(subs_size_lat(:),pr_Ei(:))

  reg_line_cl_width(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ; print("Cor: subs frac - Width (precip)")
  ; print((corr_EDIV(1))^2)
  ; print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ; print("Regression coefficient: ")
  ; print(reg_E-0.)
  ; print("  ") 

  corr_cl_width(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = cen_pres(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),cen_pres(:))
;
;  reg_line_cl_tophe(j_f-1) = reg_E
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;   print("Cor: std precip - Top heavyness")
;   print((corr_EDIV(1))^2)
;   print(corr_EDIV(1)/abs(corr_EDIV(1)))
;   print("Regression coefficient: ")
;   print(reg_E-0.)
;   print("  ") 
;
;  corr_cl_tophe(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;
;
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = top_index(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),top_index(:))
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;   print("Cor: std precip - Top index")
;   print((corr_EDIV(1))^2)
;   print(corr_EDIV(1)/abs(corr_EDIV(1)))
;   print("Regression coefficient: ")
;   print(reg_E-0.)
;   print("  ") 
;
;  delete(corr_EDIV)






  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = ACRE(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),ACRE(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - ACRE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = ACRE(:)

  reg_E=regline(subs_frac_tm(:),ACRE(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - ACRE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = TOT_rad(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),TOT_rad(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - TOT_rad")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = TOT_rad(:)

  reg_E=regline(subs_frac_tm(:),TOT_rad(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - TOT_rad")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)







  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = TURB(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),TURB(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - TURB")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = TURB(:)

  reg_E=regline(subs_frac_tm(:),TURB(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - TURB")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)







  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = UPTAKE(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - UPTAKE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = UPTAKE(:)

  reg_E=regline(subs_frac_tm(:),UPTAKE(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - UPATKE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = dphi_T1000(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),dphi_T1000(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - Mer. Temp. Gradient")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = dphi_T1000(:)
;
;  reg_E=regline(subs_frac_tm(:),dphi_T1000(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - Mer. Temp. Gradient")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)





  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = dphi_Ts(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),dphi_Ts(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Mer. Surf. Temp. Gradient")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = dphi_Ts(:)

  reg_E=regline(subs_frac_tm(:),dphi_Ts(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Mer. Surf. Temp. Gradient")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



; corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = ACRE_a(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),ACRE_a(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - ACRE (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)

;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = ACRE_a(:)
;
;  reg_E=regline(subs_frac_tm(:),ACRE_a(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - ACRE (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)
;
;
;
;
;
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = TOT_rad_a(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),TOT_rad_a(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - TOT_rad (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)
;
; 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = TOT_rad_a(:)
;
;  reg_E=regline(subs_frac_tm(:),TOT_rad_a(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - TOT_rad (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = UPTAKE_a(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE_a(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - UPTAKE (10-16)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = UPTAKE_a(:)

  reg_E=regline(subs_frac_tm(:),UPTAKE_a(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - UPATKE (10-16)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)

;
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = pr_Ei(:)
;  corr_mat_E(1,:) = UPTAKE_a(:)
;
;  reg_E=regline(pr_Ei(:),UPTAKE_a(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: Width (pr) - UPATKE (10-16)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)



;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_size_lat(:)
;  corr_mat_E(1,:) = UPTAKE_a(:)
;
;  reg_E=regline(subs_size_lat(:),UPTAKE_a(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E


;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: Width (dyn) - UPATKE (10-16)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 

;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)




;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = UPTAKE_b(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE_b(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - UPTAKE (6-12)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = UPTAKE_b(:)
;
;  reg_E=regline(subs_frac_tm(:),UPTAKE_b(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - UPATKE (6-12)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)



;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = UPTAKE_c(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE_c(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - UPTAKE (14-20)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = UPTAKE_c(:)
;
;  reg_E=regline(subs_frac_tm(:),UPTAKE_c(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - UPATKE (14-20)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)



  min_cluster(j_f-1)   = min(tm_zonvar_eq_precip_m(:))
  max_cluster(j_f-1)   = max(tm_zonvar_eq_precip_m(:))
  mean_cluster(j_f-1)  = avg(tm_zonvar_eq_precip_m(:))
  std_cluster(j_f-1)   = stddev(tm_zonvar_eq_precip_m(:))
  delta_cluster(j_f-1) = max_cluster(j_f-1) - min_cluster(j_f-1)

  min_width_pr(j_f-1)   = min(pr_Ei(:))
  max_width_pr(j_f-1)   = max(pr_Ei(:))
  mean_width_pr(j_f-1)  = avg(pr_Ei(:))
  std_width_pr(j_f-1)   = stddev(pr_Ei(:))
  delta_width_pr(j_f-1) = max_width_pr(j_f-1) - min_width_pr(j_f-1)

  min_subs_size_lat(j_f-1)   = min(subs_size_lat(:))
  max_subs_size_lat(j_f-1)   = max(subs_size_lat(:))
  mean_subs_size_lat(j_f-1)  = avg(subs_size_lat(:))
  std_subs_size_lat(j_f-1)   = stddev(subs_size_lat(:))
  delta_subs_size_lat(j_f-1) = max_subs_size_lat(j_f-1) - min_subs_size_lat(j_f-1)

  mean_subs_frac(j_f-1)  = avg(subs_frac_tm(:))
  std_subs_frac(j_f-1)   = stddev(subs_frac_tm(:))

  mean_TOT_rad(j_f-1)  = avg(TOT_rad(:))
  std_TOT_rad(j_f-1)   = stddev(TOT_rad(:))

  mean_TURB(j_f-1)  = avg(TURB(:))
  std_TURB(j_f-1)   = stddev(TURB(:))

  mean_ACRE(j_f-1)  = avg(ACRE(:))
  std_ACRE(j_f-1)   = stddev(ACRE(:))

  mean_UPTAKE(j_f-1)  = avg(UPTAKE(:))
  std_UPTAKE(j_f-1)   = stddev(UPTAKE(:))
  
  
  ;RMSE_cluster (j_f-1)  = sqrt(sum((tm_zonvar_eq_precip_m(:)-GPCP_tm_zonvar_eq_precip_m(:))^2)/month_number)
  ;RMSE_width_pr(j_f-1) = sqrt(sum((pr_Ei(:)-GPCP_pr_Ei(:))^2)/month_number)
  ;RMSE_subs_size_lat(j_f-1) = sqrt(sum((subs_size_lat(:)-ERA_subs_size_lat(:))^2)/month_number)
  ;RMSE_subs_frac(j_f-1) = sqrt(sum((subs_frac_tm(:)-ERA_subs_frac_tm(:))^2)/month_number)

;  RMSE_cluster (j_f-1)  = dim_rmsd(tm_zonvar_eq_precip_m(:),GPCP_tm_zonvar_eq_precip_m(:))
;  RMSE_width_pr(j_f-1)  = dim_rmsd(pr_Ei(:),GPCP_pr_Ei(:))
;  RMSE_subs_size_lat(j_f-1) = dim_rmsd(subs_size_lat(:),ERA_subs_size_lat(:))
;  RMSE_subs_frac(j_f-1) = dim_rmsd(subs_frac_tm(:),ERA_subs_frac_tm(:))


 ;print(" ")  
 ;print("Mean Value Clustering:")
 ;print(mean_cluster(j_f-1)-0.)
 ;print("Std Value Clustering:")
 ;print(std_cluster(j_f-1)-0.)
 ;print("RMSE clustering:")
 ;print(RMSE_cluster (j_f-1)-0.)
 ;
 ;print(" ")
 ;print("Mean Subsidence Fraction:")
 ;print(mean_subs_frac(j_f-1)-0.)
 ;print("Std Subsidence Fraction:")
 ;print(std_subs_frac(j_f-1)-0.)
 ;print("RMSE Subsidence Fraction")
 ;print(RMSE_subs_frac(j_f-1)-0.)
 ;
 ;print(" ")
 ;print("Mean Value Width (pr):")
 ;print(mean_width_pr(j_f-1)-0.)
 ;print("Std Value Width (pr):")
 ;print(std_width_pr(j_f-1)-0.)
 ;print("RMSE Width (pr):")
 ;print(RMSE_width_pr (j_f-1)-0.)
 ;
 ;print(" ")
 ;print("Mean Value Width (dyn):")
 ;print(mean_subs_size_lat(j_f-1)-0.)
 ;print("Std Value Width (dyn):")
 ;print(std_subs_size_lat(j_f-1)-0.)
 ;print("RMSE Width (dyn):")
 ;print(RMSE_subs_size_lat(j_f-1)-0.)


 print(" ")  
 print("Mean ACRE:")
 print(mean_ACRE(j_f-1)-0.)
 print("Std ACRE:")
 print(std_ACRE(j_f-1)-0.)

 print(" ")  
 print("Mean TOT_rad:")
 print(mean_TOT_rad(j_f-1)-0.)
 print("Std TOT_rad:")
 print(std_TOT_rad(j_f-1)-0.)

 print(" ")  
 print("Mean TURB:")
 print(mean_TURB(j_f-1)-0.)
 print("Std TURB:")
 print(std_TURB(j_f-1)-0.)

 print(" ")  
 print("Mean UPTAKE:")
 print(mean_UPTAKE(j_f-1)-0.)
 print("Std UPTAKE:")
 print(std_UPTAKE(j_f-1)-0.)



  print("  ")
  print("  ")
  print("Symmetric:")
  print("  ")
;  print("Min Value clustering:")
;  print(min(tm_zonvar_eq_precip_m_sym_sel(:)))
;  print("Max Value clustering:")
;  print(max(tm_zonvar_eq_precip_m_sym_sel(:)))
;  print("  ")
;  print("Min Value Width (precip):")
;  print(min(pr_Ei_sym_sel(:)))
;  print("Max Value Width (precip):")
;  print(max(pr_Ei_sym_sel(:)))
;  print("  ")
;  print("Min Value Width (dyn):")
;  print(min(subs_size_lat_sym_sel(:)))
;  print("Max Value Width (dyn):")
;  print(max(subs_size_lat_sym_sel(:)))
;  print("  ")    
 




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = subs_frac_tm_sym_sel(:)

   reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),subs_frac_tm_sym_sel(:))

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ;print("Cor: std precip - subs frac")
  ;print((corr_EDIV(1))^2)
  ;print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ;print("Regression coefficient: ")
  ;print(reg_E-0.)
  ;print("  ")
 

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),pr_Ei(:))

  reg_line_cl_width_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ;print("Cor: std precip - pr_Ei")
  ;print((corr_EDIV(1))^2)
  ;print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ;print("Regression coefficient: ")
  ;print(reg_E-0.)
  ;print("  ")

  corr_cl_width_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = cen_pres(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),cen_pres(:))

;  reg_line_cl_tophe_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Top heavyness")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_cl_tophe_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = top_index(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),top_index(:))

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
   print("Cor: std precip - Top index")
   print((corr_EDIV(1))^2)
   print(corr_EDIV(1)/abs(corr_EDIV(1)))
   print("Regression coefficient: ")
   print(reg_E-0.)
   print("  ") 

   corr_cl_top_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = shallow(:)

  

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_cl_shallow_sym(j_f-1) = (corr_EDIV(1))^2

   print("Cor: std precip - Shallow")
   print((corr_EDIV(1))^2)
   print(corr_EDIV(1)/abs(corr_EDIV(1)))
   print("Regression coefficient: ")
   print(reg_E-0.)
   print("  ") 
 

  delete(corr_EDIV)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = cen_pres(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),cen_pres(:))

;  reg_line_cl_tophe_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Subs frac - Cen pres")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_sf_cenpres_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = top_index(:)
  ;corr_mat_E(1,:) = cen_pres(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),top_index(:))

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
   print("Cor: Subs frac - Top index")
   print((corr_EDIV(1))^2)
   print(corr_EDIV(1)/abs(corr_EDIV(1)))
   print("Regression coefficient: ")
   print(reg_E-0.)
   print("  ")

   corr_sf_top_sym(j_f-1) = (corr_EDIV(1))^2 ;* corr_EDIV(1)/abs(corr_EDIV(1))
   sign_sf_top_sym(j_f-1) = corr_EDIV(1)/abs(corr_EDIV(1))
   ;corr_sf_top_sym(j_f-1) = avg(top_index(:))
   ;sign_sf_top_sym(j_f-1) = avg(cen_pres(:))

  delete(corr_EDIV)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = shallow(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),shallow(:))

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
   print("Cor: Subs frac - Shallow")
   print((corr_EDIV(1))^2)
   print(corr_EDIV(1)/abs(corr_EDIV(1)))
   print("Regression coefficient: ")
   print(reg_E-0.)
   print("  ")
 
  ;corr_sf_top_sym(j_f-1) = (corr_EDIV(1))^2
  corr_sf_shallow_sym(j_f-1) = (corr_EDIV(1))^2
  ;corr_sf_shallow_sym(j_f-1) = avg(shallow(:))
  delete(corr_EDIV)






  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = subs_size_lat(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),subs_size_lat(:))

  reg_line_cl_ssl_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ;print("Cor: std precip - Width (dyn)")
  ;print((corr_EDIV(1))^2)
  ;print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ;print("Regression coefficient: ")
  ;print(reg_E-0.)
  ;print("  ")


  corr_cl_ssl_sym(j_f-1) = (corr_EDIV(1))^2
 
  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = subs_size_lat(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),subs_size_lat(:))

  reg_line_cl_ssl_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ;print("Cor: std precip - Width (dyn)")
  ;print((corr_EDIV(1))^2)
  ;print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ;print("Regression coefficient: ")
  ;print(reg_E-0.)
  ;print("  ")


  corr_cl_ssl_sym(j_f-1) = (corr_EDIV(1))^2
 
  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)






 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat_sym_sel(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(subs_size_lat_sym_sel(:),pr_Ei(:))

  reg_line_cl_width_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ;print("Cor: Subs frac - pr_Ei")
  ;print((corr_EDIV(1))^2)
  ;print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ;print("Regression coefficient: ")
  ;print(reg_E-0.)
  ;print("  ")

  corr_cl_width_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = subs_size_lat_sym_sel(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),subs_size_lat_sym_sel(:))

 
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  ;print("Cor: Subs frac - Width (dyn)")
  ;print((corr_EDIV(1))^2)
  ;print(corr_EDIV(1)/abs(corr_EDIV(1)))
  ;print("Regression coefficient: ")
  ;print(reg_E-0.)
  ;print("  ")


  
  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)










  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = ACRE_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),ACRE_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - ACRE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_cl_ACRE_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = ACRE_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),ACRE_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - ACRE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_sf_ACRE_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = TOT_rad_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),TOT_rad_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - TOT_rad")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_cl_RAD_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = TOT_rad_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),TOT_rad_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - TOT_rad")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_sf_RAD_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = TURB_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),TURB_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - TURB")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_cl_TURB_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = TURB_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),TURB_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - TURB")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_sf_TURB_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = UPTAKE_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),UPTAKE_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Uptake")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_cl_UPTAKE_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = UPTAKE_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),UPTAKE_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Uptake")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_sf_UPTAKE_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)






; corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = ACRE_a_sym_sel(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),ACRE_a_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - ACRE (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = ACRE_a_sym_sel(:)

;  reg_E=regline(subs_frac_tm(:),ACRE_a_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - ACRE (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)





;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = TOT_rad_a_sym_sel(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),TOT_rad_a_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - TOT_rad (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = TOT_rad_a_sym_sel(:)
;
;  reg_E=regline(subs_frac_tm(:),TOT_rad_a_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - TOT_rad (away)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = UPTAKE_a_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE_a_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - UPTAKE (10-16)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

;  corr_cl_uptake(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = UPTAKE_a_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),UPTAKE_a_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - UPATKE (10-16)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  ;corr_sf_uptake(j_f-1) = (corr_EDIV(1))^2
  corr_sf_uptake_10_16_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)








  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = UPTAKE_sym_sel(:) - UPTAKE_a_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE_sym_sel(:) - UPTAKE_a_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Delta UPTAKE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

;  corr_cl_uptake(j_f-1) = (corr_EDIV(1))^2

  corr_cl_delta_uptake_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = UPTAKE_sym_sel(:) - UPTAKE_a_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),UPTAKE_sym_sel(:) - UPTAKE_a_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Delta UPATKE")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_sf_delta_uptake_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = pr_Ei(:)
;  corr_mat_E(1,:) = UPTAKE_a_sym_sel(:)
;
;  reg_E=regline(pr_Ei(:),UPTAKE_a_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: Width (pr) - UPATKE (10-16)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;
;
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)



;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_size_lat(:)
;  corr_mat_E(1,:) = UPTAKE_a_sym_sel(:)
;
;  reg_E=regline(subs_size_lat(:),UPTAKE_a_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: Width (dyn) - UPATKE (10-16)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)





 ; corr_mat_E      = new((/2,month_number/),float)
 ; corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
 ; corr_mat_E(1,:) = UPTAKE_b_sym_sel(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE_b_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - UPTAKE (6-12)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = UPTAKE_b_sym_sel(:)
;
;  reg_E=regline(subs_frac_tm(:),UPTAKE_b_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - UPATKE (6-12)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)




;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = UPTAKE_c_sym_sel(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),UPTAKE_c_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - UPTAKE (14-20)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = UPTAKE_c_sym_sel(:)
;
;  reg_E=regline(subs_frac_tm(:),UPTAKE_c_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - UPATKE (14-20)")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)






;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
;  corr_mat_E(1,:) = dphi_T1000_sym_sel(:)
;
;  reg_E=regline(tm_zonvar_eq_precip_m(:),dphi_T1000_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Conv. Clustering - Mer. Temp. Gradient")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
;  delete(reg_E)


 
;  corr_mat_E      = new((/2,month_number/),float)
;  corr_mat_E(0,:) = subs_frac_tm(:)
;  corr_mat_E(1,:) = dphi_T1000_sym_sel(:)
;
;  reg_E=regline(subs_frac_tm(:),dphi_T1000_sym_sel(:))
;
;  reg_line_cl_ssl(j_f-1) = reg_E
;
;
;  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
;  print("Cor: subs frac - Mer. Temp. Gradient")
;  print((corr_EDIV(1))^2)
;  print(corr_EDIV(1)/abs(corr_EDIV(1)))
;  print("Regression coefficient: ")
;  print(reg_E-0.)
;  print("  ") 
;
;  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
;
;  delete(corr_EDIV)
;  delete(corr_mat_E)
 ; delete(reg_E)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = dphi_Ts_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),dphi_Ts_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Mer. Surf. Temp. Gradient")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_dphi_Ts_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = dphi_Ts_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),dphi_Ts_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Mer. Surf. Temp. Gradient")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_sf_dphi_Ts_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)










  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = Ts_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),Ts_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Surf. Temp.")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_Ts_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = Ts_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),Ts_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Surf. Temp.")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 


  corr_sf_Ts_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = Ts_nt_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),Ts_nt_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Surf. Temp. (no trend)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = Ts_nt_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),Ts_nt_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Surf. Temp. (no trend)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = Ts_std_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),Ts_std_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Std Surf. Temp.")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = Ts_std_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),Ts_std_sym_sel(:))

  ;reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Std Surf. Temp. ")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = tm_zonvar_eq_tas_m(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),tm_zonvar_eq_tas_m(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Conv. Clustering - Temp. clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = tm_zonvar_eq_tas_m(:)

  reg_E=regline(subs_frac_tm(:),tm_zonvar_eq_tas_m(:))

  ;reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Temp. clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = Ts_std_sym_sel(:)
  corr_mat_E(1,:) = tm_zonvar_eq_tas_m(:)

  reg_E=regline(Ts_std_sym_sel(:),tm_zonvar_eq_tas_m(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Std Surf. Temp. - Temp. clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 






 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = MSE_850_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),MSE_850_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - MSE 850hPa")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = MSE_850_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),MSE_850_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Conv. clust. - MSE 850hPa")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = dphi_MSE_sym_sel(:)

  reg_E=regline(subs_frac_tm(:),dphi_MSE_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Mer grad MSE 850hPa")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_sf_dphi_MSE_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = dphi_MSE_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),dphi_MSE_sym_sel(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Conv. clust. - Mer grad MSE 850hPa")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_cl_dphi_MSE_sym(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)








  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = pr_Ei_sym_sel(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))

   corr_cl_wpr(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
 


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = pr_Ei_sym_sel(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))

   corr_sf_wpr(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  


 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = subs_size_lat_sym_sel(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))

   corr_cl_wdy(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = subs_size_lat_sym_sel(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))

   corr_sf_wdy(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)









  min_cluster_sym(j_f-1)   = min(tm_zonvar_eq_precip_m_sym_sel(:))
  max_cluster_sym(j_f-1)   = max(tm_zonvar_eq_precip_m_sym_sel(:))
  mean_cluster_sym(j_f-1)  = avg(tm_zonvar_eq_precip_m_sym_sel(:))
  std_cluster_sym(j_f-1)   = stddev(tm_zonvar_eq_precip_m_sym_sel(:))
  delta_cluster_sym(j_f-1) = max_cluster_sym(j_f-1) - min_cluster_sym(j_f-1)

  mean_cluster_tas_sym(j_f-1)  = avg(tm_zonvar_eq_tas_m_sym_sel(:))

  min_width_pr_sym(j_f-1)   = min(pr_Ei_sym_sel(:))
  max_width_pr_sym(j_f-1)   = max(pr_Ei_sym_sel(:))
  mean_width_pr_sym(j_f-1)  = avg(pr_Ei_sym_sel(:))
  std_width_pr_sym(j_f-1)   = stddev(pr_Ei_sym_sel(:))
  delta_width_pr_sym(j_f-1) = max_width_pr_sym(j_f-1) - min_width_pr_sym(j_f-1)

  min_subs_size_lat_sym(j_f-1)   = min(subs_size_lat_sym_sel(:))
  max_subs_size_lat_sym(j_f-1)   = max(subs_size_lat_sym_sel(:))
  mean_subs_size_lat_sym(j_f-1)  = avg(subs_size_lat_sym_sel(:))
  std_subs_size_lat_sym(j_f-1)   = stddev(subs_size_lat_sym_sel(:))
  delta_subs_size_lat_sym(j_f-1) = max_subs_size_lat_sym(j_f-1) - min_subs_size_lat_sym(j_f-1)

  mean_subs_frac_sym(j_f-1)  = avg(subs_frac_tm_sym_sel(:))
  std_subs_frac_sym(j_f-1)   = stddev(subs_frac_tm_sym_sel(:))


  mean_TOT_rad_sym(j_f-1)  = avg(TOT_rad_sym_sel(:))
  std_TOT_rad_sym(j_f-1)   = stddev(TOT_rad_sym_sel(:))

  mean_TURB_sym(j_f-1)  = avg(TURB_sym_sel(:))
  std_TURB_sym(j_f-1)   = stddev(TURB_sym_sel(:))

  mean_ACRE_sym(j_f-1)  = avg(ACRE_sym_sel(:))
  std_ACRE_sym(j_f-1)   = stddev(ACRE_sym_sel(:))

  mean_UPTAKE_sym(j_f-1)  = avg(UPTAKE_sym_sel(:))
  std_UPTAKE_sym(j_f-1)   = stddev(UPTAKE_sym_sel(:))

  mean_TS_sym(j_f-1)  = avg(Ts_sym_sel(:))
  std_TS_sym(j_f-1)   = stddev(Ts_sym_sel(:))
 

;  RMSE_cluster_sym (j_f-1)  = sqrt(sum((tm_zonvar_eq_precip_m_sym_sel(:)-GPCP_tm_zonvar_eq_precip_m_sym_sel(:))^2)/month_number_sym)
;  RMSE_width_pr_sym(j_f-1) = sqrt(sum((pr_Ei_sym_sel(:)-GPCP_pr_Ei_sym_sel(:))^2)/month_number_sym)
;  RMSE_subs_size_lat_sym(j_f-1) = sqrt(sum((subs_size_lat_sym_sel(:)-ERA_subs_size_lat_sym_sel(:))^2)/month_number_sym)
;  RMSE_subs_frac_sym(j_f-1) = sqrt(sum((subs_frac_tm_sym_sel(:)-ERA_subs_frac_tm_sym_sel(:))^2)/month_number_sym)


  ;RMSE_cluster_sym (j_f-1)  = dim_rmsd(tm_zonvar_eq_precip_m_sym_sel(:),GPCP_tm_zonvar_eq_precip_m_sym_sel(:))
  ;RMSE_width_pr_sym(j_f-1)  = dim_rmsd(pr_Ei_sym_sel(:),GPCP_pr_Ei_sym_sel(:))
  ;RMSE_subs_size_lat_sym(j_f-1) = dim_rmsd(subs_size_lat_sym_sel(:),ERA_subs_size_lat_sym_sel(:))
  ;RMSE_subs_frac_sym(j_f-1) = dim_rmsd(subs_frac_tm_sym_sel(:),ERA_subs_frac_tm_sym_sel(:))


 ;print(" ")
 ;print("Mean Value Clustering:")
 ;print(mean_cluster_sym(j_f-1)-0.)
 ;print("Std Value Clustering:")
 ;print(std_cluster_sym(j_f-1)-0.)
 ;print("RMSE clustering:")
 ;print(RMSE_cluster_sym(j_f-1)-0.)


 ;print(" ")
 ;print("Mean Subsidence Fraction:")
 ;print(mean_subs_frac_sym(j_f-1)-0.)
 ;print("Std Subsidence Fraction:")
 ;print(std_subs_frac_sym(j_f-1)-0.)
 ;print("RMSE Subsidence Fraction")
 ;print(RMSE_subs_frac_sym(j_f-1)-0.)


 ;print(" ")
 ;print("Mean Value Width (pr):")
 ;print(mean_width_pr_sym(j_f-1)-0.)
 ;print("Std Value Width (pr):")
 ;print(std_width_pr_sym(j_f-1)-0.)
 ;print("RMSE Width (pr):")
 ;print(RMSE_width_pr_sym(j_f-1)-0.)

 ;print(" ")
 ;print("Mean Value Width (dyn):")
 ;print(mean_subs_size_lat_sym(j_f-1)-0.)
 ;print("Std Value Width (dyn):")
 ;print(std_subs_size_lat_sym(j_f-1)-0.)
 ;print("RMSE Width (dyn):")
 ;print(RMSE_subs_size_lat_sym(j_f-1)-0.)



 print(" ")  
 print("Mean ACRE:")
 print(mean_ACRE_sym(j_f-1)-0.)
 print("Std ACRE:")
 print(std_ACRE_sym(j_f-1)-0.)

 print(" ")  
 print("Mean TOT_rad:")
 print(mean_TOT_rad_sym(j_f-1)-0.)
 print("Std TOT_rad:")
 print(std_TOT_rad_sym(j_f-1)-0.)

 print(" ")  
 print("Mean TURB:")
 print(mean_TURB_sym(j_f-1)-0.)
 print("Std TURB:")
 print(std_TURB_sym(j_f-1)-0.)

 print(" ")  
 print("Mean UPTAKE:")
 print(mean_UPTAKE_sym(j_f-1)-0.)
 print("Std UPTAKE:")
 print(std_UPTAKE_sym(j_f-1)-0.)

 
  print("----------------------------------------- ")
  print("----------------------------------------- ")



  delete(Ts_nt)
  delete(precip_mm_o_2)
  delete(precip_mm_o)
  delete(precip_mm)

  delete(pr_Ai)
  delete(pr_Ei)

  delete(tm_zonvar_eq_precip_m_sym_sel)

  delete(tm_zonvar_eq_precip_m)
  delete(tm_zonavg_eq_precip_m)

   delete(lat)
   delete(lev)
  delete(lat_number)
  delete(lon)
  delete(lon_number)

  delete(file1)
  delete(file_m)

  delete(MSE_850)


  delete(time)
  delete(time_number)
  delete(utc_date)
  delete(month_change)
  delete(month_days)
  delete(days_since_start)
  delete(subs_size_lat)

  delete(subs_frac_tm)

;  delete(mean_TOT_rad)
;  delete(mean_TOT_rad_sym)
;
;  delete(mean_ACRE)
;  delete(mean_ACRE_sym)
;
;  delete(mean_UPTAKE)
;  delete(mean_UPTAKE_sym)
;
;  delete(mean_TURB)
;  delete(mean_TURB_sym)
;
; 
;  delete(std_TOT_rad)
;  delete(std_TOT_rad_sym)
;
;  delete(std_ACRE)
;  delete(std_ACRE_sym)
;
;  delete(std_UPTAKE)
;  delete(std_UPTAKE_sym)
;
;  delete(std_TURB)
;  delete(std_TURB_sym)

  delete(TOT_rad) 
  delete(ACRE)    
  delete(UPTAKE) 
  delete(TURB)    
  delete(shallow)
  delete(top_index)
  delete(cen_pres)


end do 
















  print("  ")


  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Mean Atm. Cooling")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TOT_rad(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = mean_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = mean_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = mean_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TOT_rad(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TOT_rad(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = mean_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = mean_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 





 print("----------------------------------------- ")
  print("  ")
  print ("Corrs: StD Atm. Cooling")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TOT_rad(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Spread Atm. Cooling")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = std_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Spread Atm. Cooling")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = std_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = std_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TOT_rad(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TOT_rad(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = std_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = std_TOT_rad(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 







  print("  ")


  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Mean ACRE")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_ACRE(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = mean_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = mean_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = mean_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_ACRE(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_ACRE(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = mean_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = mean_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 





 print("----------------------------------------- ")
  print("  ")
  print ("Corrs: StD ACRE")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_ACRE(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = std_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = std_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = std_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_ACRE(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_ACRE(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = std_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = std_ACRE(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 








print("  ")
print("  ")
print("  ")
print("  ")
print("  ")
print("----------------------------------------- ")
  print("  ")
  print("----------------------------------------- ")
  print("  ")
  print("Symmetric:")
  print("  ")
  print("----------------------------------------- ")
  print("  ")
 print("----------------------------------------- ")
print("  ")
print("  ")
print("  ")
print("  ")
print("  ")

 




  print("  ")


  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Mean Atm. Cooling")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TOT_rad_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = mean_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TOT_rad_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TOT_rad_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Atm. Cooling - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 





 print("----------------------------------------- ")
  print("  ")
  print ("Corrs: StD Atm. Cooling")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TOT_rad_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Spread Atm. Cooling")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = std_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Spread Atm. Cooling")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = std_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = std_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TOT_rad_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TOT_rad_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_TOT_rad_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread Atm. Cooling - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 







  print("  ")


  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Mean ACRE")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_ACRE_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = mean_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_ACRE_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_ACRE_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean ACRE - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 





 print("----------------------------------------- ")
  print("  ")
  print ("Corrs: StD ACRE")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_ACRE_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = std_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = std_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = std_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_ACRE_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_ACRE_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_ACRE_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Spread ACRE - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 






 print("  ")
 print("  ")
 print("  ")
 print("  ")
print("----------------------------------------- ")
print("----------------------------------------- ")
print("----------------------------------------- ")
print("----------------------------------------- ")
print("----------------------------------------- ")
 print("  ")
 print("  ")
 print("  ")
 print("  ")



   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_cl_uptake(:)
  corr_mat_E(1,:) = corr_sf_uptake(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. Clust. Uptake - Cor. SF Uptake")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 
  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_cl_uptake(:)
  corr_mat_E(1,:) = corr_cl_wpr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. Clust. Uptake - Cor. Clust. Width (pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_cl_uptake(:)
  corr_mat_E(1,:) = corr_cl_wdy(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. Clust. Uptake - Cor. Clust. Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
 
  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_cl_uptake(:)
  corr_mat_E(1,:) = corr_sf_wpr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. Clust. Uptake - Cor. SF Width (pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_cl_uptake(:)
  corr_mat_E(1,:) = corr_sf_wdy(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. Clust. Uptake - Cor. SF Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")
print("----------------------------------------- ")



print("----------------------------------------- ")

   print("  ")
 
  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_sf_uptake(:)
  corr_mat_E(1,:) = corr_cl_wpr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))

  print("Cor: Cor. SF Uptake - Cor. Clust. Width (pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_sf_uptake(:)
  corr_mat_E(1,:) = corr_cl_wdy(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. SF Uptake - Cor. Clust. Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
 
  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_sf_uptake(:)
  corr_mat_E(1,:) = corr_sf_wpr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. SF Uptake - Cor. SF Width (pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = corr_sf_uptake(:)
  corr_mat_E(1,:) = corr_sf_wdy(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Cor. SF Uptake - Cor. SF Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





  print("  ")
  print("  ")
print("----------------------------------------- ")
  print("  ")
print("----------------------------------------- ")
  print("  ")
print("----------------------------------------- ")
  print("  ")
  print("  ")
  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TS_sym(:)
  corr_mat_E(1,:) = mean_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Subs. Frac. - Surf Temp")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_TS_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Conv. Clust. - Surf Temp")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TS_sym(:)
  corr_mat_E(1,:) = mean_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Subs. Frac. - Std. Surf Temp")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_TS_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Conv. Clust. - Std. Surf Temp")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_cluster_tas_sym(:)
  corr_mat_E(1,:) = mean_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Subs. Frac. - Temp. Clust.")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_cluster_tas_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Conv. Clust. - Temp. Clust.")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)








  ;print(mean_cluster_sym)
  
  ;print(mean_width_pr_sym)  

  ;print(mean_subs_size_lat_sym)


  ;print(reg_line_cl_width_sym)

  ;print(reg_line_cl_ssl_sym)


 ; print(corr_cl_width_sym)

 ; print(corr_cl_ssl_sym)



  ;print(std_cluster)

  ;print(RMSE_cluster)

  ;print(RMSE_cluster_sym)


  ;print(RMSE_width_pr)

  ;print(RMSE_width_pr_sym) 


  
  ;print(RMSE_subs_size_lat)

  ;print(RMSE_subs_size_lat_sym) 



;========================================================================================================
 res_ep=True

  res_ep@tiMainFont = 21
  res_ep@tiMainFontHeightF = 0.022
  res_ep@tiYAxisFont    = 21
  res_ep@tiYAxisFontHeightF = 0.022 
  res_ep@tiXAxisString  = "Normalized StD of precipitaion"
  res_ep@tiYAxisString  = "P~B~E~N~ [mm day~S~-1~N~]"
  res_ep@tiXAxisFont    = 21
  res_ep@tiXAxisFontHeightF = 0.022

  res_ep@tiMainOffsetYF = -0.015
 
  res_ep@vpWidthF          = 0.5
  res_ep@vpHeightF         = 0.5

  res_ep@tmYLLabelFontHeightF = 0.02 
  res_ep@tmXBLabelFontHeightF = 0.02 

  res_ep@gsnDraw        = False
  res_ep@gsnFrame       = False
  
  res_ep@xyMarkLineMode="Markers"

  res_ep@xyMarker=4

  res_ep@pmLegendDisplayMode    = "Never"

  res_ep@xyMarkerSizeF=15.
  res_ep@xyMarkerThicknessF=3.


  X_color= new(m_number,string)

  X_color(:)="black"
  X_color(0)="red" 

  res_ep@xyMarkerColors = X_color


  tx_id = True
  tx_id@txFontHeightF = 0.0175
  ;tx_id@txJust        = "TopLeft"
  tx_id@txPosXF=-0.00
  
  tx_id@txAngleF        = 45.
 
  


;===========================================================================================================
; Plots: Scatter plots

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_mean")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)

  labels = new ((/4,m_number,m_number/),string)


  X_string(0) = "Mean Conv. clustering"
  X_string(1) = "Mean Conv. clustering"
  X_string(2) = "Mean Conv. clustering (sym)"
  X_string(3) = "Mean Conv. clustering (sym)"


  Y_string(0) = "Mean ITCZ width (pr)"
  Y_string(1) = "Mean ITCZ width (dyn)"
  Y_string(2) = "Mean ITCZ width (pr)"
  Y_string(3) = "Mean ITCZ width (dyn)" 

  
  ;X_vec(0,:) = mean_cluster(:)
  ;X_vec(1,:) = mean_cluster(:)
  ;X_vec(2,:) = mean_cluster_sym(:)
  ;X_vec(3,:) = mean_cluster_sym(:)


  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1)  = mean_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1)  = mean_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1)  = mean_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1)  = mean_cluster_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1)  = mean_width_pr(j_f-1)
    Y_vec(1,j_f-1,j_f-1)  = mean_subs_size_lat(j_f-1)
    Y_vec(2,j_f-1,j_f-1)  = mean_width_pr_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1)  = mean_subs_size_lat_sym(j_f-1)
    labels(0,j_f-1,j_f-1) = file_names(j_f-1)
    labels(1,j_f-1,j_f-1) = file_names(j_f-1)
    labels(2,j_f-1,j_f-1) = file_names(j_f-1)
    labels(3,j_f-1,j_f-1) = file_names(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    ;print(j_p)
    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)

  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))




;=================================================================================================

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_std")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "Std Conv. clustering"
  X_string(1) = "Std Conv. clustering"
  X_string(2) = "Std Conv. clustering (sym)"
  X_string(3) = "Std Conv. clustering (sym)"


  Y_string(0) = "Std ITCZ width (pr)"
  Y_string(1) = "Std ITCZ width (dyn)"
  Y_string(2) = "Std ITCZ width (pr)"
  Y_string(3) = "Std ITCZ width (dyn)" 

  
  
  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = std_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1) = std_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1) = std_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = std_cluster_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = std_width_pr(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = std_subs_size_lat(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = std_width_pr_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = std_subs_size_lat_sym(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))




;=================================================================================================

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_mean_std")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "Mean Conv. clustering"
  X_string(1) = "Mean Conv. clustering"
  X_string(2) = "Mean Conv. clustering (sym)"
  X_string(3) = "Mean Conv. clustering (sym)"


  Y_string(0) = "Std Conv. clustering"
  Y_string(1) = "Std Conv. clustering"
  Y_string(2) = "Std Conv. clustering (sym)"
  Y_string(3) = "Std Conv. clustering (sym)"



  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = mean_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1) = mean_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = std_cluster(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = std_cluster(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = std_cluster_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = std_cluster_sym(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))






;=================================================================================================

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_mean_corr")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "Mean Conv. clustering"
  X_string(1) = "Mean Conv. clustering"
  X_string(2) = "Mean Conv. clustering (sym)"
  X_string(3) = "Mean Conv. clustering (sym)"


  Y_string(0) = "Corr. Mean clust - Mean width pr"
  Y_string(1) = "Corr. Mean clust - Mean width dyn"
  Y_string(2) = "Corr. Mean clust - Mean width pr"
  Y_string(3) = "Corr. Mean clust - Mean width dyn"


  
  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = mean_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1) = mean_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)    
    Y_vec(0,j_f-1,j_f-1) = corr_cl_width(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = corr_cl_ssl(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = corr_cl_width_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = corr_cl_ssl_sym(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

       txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))






;=================================================================================================

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_corr_regres")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "Corr. Clust - Mean width pr"
  X_string(1) = "Corr. Clust - Mean width dyn"
  X_string(2) = "Corr. Clust - Mean width pr"
  X_string(3) = "Corr. Clust - Mean width dyn"


  Y_string(0) = "Regres. Clust - Mean width pr"
  Y_string(1) = "Regres. Clust - Mean width dyn"
  Y_string(2) = "Regres. Clust - Mean width pr"
  Y_string(3) = "Regres. Clust - Mean width dyn"


  
  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = corr_cl_width(j_f-1)
    X_vec(1,j_f-1,j_f-1) = corr_cl_ssl(j_f-1)
    X_vec(2,j_f-1,j_f-1) = corr_cl_width_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = corr_cl_ssl_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = reg_line_cl_width(j_f-1)-reg_line_cl_width(0)
    Y_vec(1,j_f-1,j_f-1) = reg_line_cl_ssl(j_f-1)-reg_line_cl_ssl(0)
    Y_vec(2,j_f-1,j_f-1) = reg_line_cl_width_sym(j_f-1)-reg_line_cl_width_sym(0)
    Y_vec(3,j_f-1,j_f-1) = reg_line_cl_ssl_sym(j_f-1)-reg_line_cl_ssl_sym(0)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))







;===================================================================================================================================================


 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_RMSE")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "RMSE Conv. clustering"
  X_string(1) = "RMSE Conv. clustering"
  X_string(2) = "RMSE Conv. clustering (sym)"
  X_string(3) = "RMSE Conv. clustering (sym)"


  Y_string(0) = "RMSE ITCZ width (pr)"
  Y_string(1) = "RMSE ITCZ width (dyn)"
  Y_string(2) = "RMSE ITCZ width (pr)"
  Y_string(3) = "RMSE ITCZ width (dyn)" 

  
  
  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = RMSE_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1) = RMSE_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1) = RMSE_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = RMSE_cluster_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = RMSE_width_pr(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = RMSE_subs_size_lat(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = RMSE_width_pr_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = RMSE_subs_size_lat_sym(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))



;===================================================================================================================================================


 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_RMSE_corr_width")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "RMSE Width (pr)"
  X_string(1) = "RMSE Width (dyn)"
  X_string(2) = "RMSE Width (pr) (sym)"
  X_string(3) = "RMSE Width (dyn) (sym)"
 
  Y_string(0) = "Corr. Clust - Mean width pr"
  Y_string(1) = "Corr. Clust - Mean width dyn"
  Y_string(2) = "Corr. Clust - Mean width pr"
  Y_string(3) = "Corr. Clust - Mean width dyn" 
  
  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = RMSE_width_pr(j_f-1)
    X_vec(1,j_f-1,j_f-1) = RMSE_subs_size_lat(j_f-1)
    X_vec(2,j_f-1,j_f-1) = RMSE_width_pr_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = RMSE_subs_size_lat_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = corr_cl_width(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = corr_cl_ssl(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = corr_cl_width_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = corr_cl_ssl_sym(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))



;===================================================================================================================================================


 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_RMSE_corr")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "RMSE Conv. clustering"
  X_string(1) = "RMSE Conv. clustering"
  X_string(2) = "RMSE Conv. clustering (sym)"
  X_string(3) = "RMSE Conv. clustering (sym)"
 
  Y_string(0) = "Corr. Clust - Mean width pr"
  Y_string(1) = "Corr. Clust - Mean width dyn"
  Y_string(2) = "Corr. Clust - Mean width pr"
  Y_string(3) = "Corr. Clust - Mean width dyn" 
  



  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = RMSE_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1) = RMSE_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1) = RMSE_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = RMSE_cluster_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = corr_cl_width(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = corr_cl_ssl(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = corr_cl_width_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = corr_cl_ssl_sym(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))




;===================================================================================================================================================


 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_clust_subsfrac")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


 
  


  X_string(0) = "Mean Conv. clustering"
  X_string(1) = "Std Conv. clustering"
  X_string(2) = "Mean Conv. clustering (sym)"
  X_string(3) = "Std Conv. clustering (sym)"

  Y_string(0) = "Mean Subs. frac."
  Y_string(1) = "Std Subs. frac."
  Y_string(2) = "Mean Subs. frac. (sym)"
  Y_string(3) = "Std Subs. frac. (sym)"


  


  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = mean_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1) = std_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = std_cluster_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = mean_subs_frac(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = std_subs_frac(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = std_subs_frac(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))








;===================================================================================================================================================

wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"AMIP_comp_RMSE_subs")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "RMSE Conv. clustering"
  X_string(1) = "RMSE Conv. clustering"
  X_string(2) = "RMSE Conv. clustering (sym)"
  X_string(3) = "RMSE Conv. clustering (sym)"

  Y_string(0) = "RMSE Subs. frac."
  Y_string(1) = "RMSE Subs. frac."
  Y_string(2) = "RMSE Subs. frac. (sym)"
  Y_string(3) = "RMSE Subs. frac. (sym)"
 
  



  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = RMSE_cluster(j_f-1)
    X_vec(1,j_f-1,j_f-1) = RMSE_cluster(j_f-1)
    X_vec(2,j_f-1,j_f-1) = RMSE_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = RMSE_cluster_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = RMSE_subs_frac(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = RMSE_subs_frac(j_f-1)
    Y_vec(2,j_f-1,j_f-1) = RMSE_subs_frac(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = RMSE_subs_frac(j_f-1)
  end do
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

  
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))


;==============================================================================================================================
delete(plot)
delete(wks)


file_str =new(18,string)
file_str(0)="Multi-model mean"
file_str(1)="ACCESS1-3"
file_str(2)="bcc-csm1-1"
file_str(3)="BNU-ESM"
file_str(4)="CanAM4"

;file_names(5)="CMCC-CM"
file_str(5)="CCSM4"
file_str(6)="CNRM-CM5"
file_str(7)="FGOALS-s2"

file_str(8)="GFDL-CM3"
file_str(9)="GFDL-HIRAM-C360"
file_str(10)="IPSL-CM5A-MR"
file_str(11)="MIROC5"

file_str(12)="MIROC-ESM"
file_str(13)="MPI-ESM-LR"

file_str(14)="MPI-ESM-MR"
file_str(15)="MRI-AGCM3-2S"
file_str(16)="MRI-CGCM3"
file_str(17)="NorESM1-M"


;file_names(17)="GPCP"
;file_names(11)="HadGEM2-A"
;file_names(13)="IPSL-CM5A-MR"
;file_names(15)="MRI-AGCM3-2S"
;file_names(7)="EC-EARTH"
;file_names(11)="GISS-E2-R"
;file_names(12)="inmcm4"




  x          = ispan(1,m_number,1)

  rgba      = span_color_rgba("matlab_jet",30)

  printVarSummary(rgba)


  print(corr_sf_ACRE_sym)

  plot_sf_ACRE_sym = new(m_number,float)
  plot_sf_ACRE_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_ACRE_sym(j_m-1) = corr_sf_ACRE_sym(j_m)
    plot_sf_ACRE_str(j_m-1) = file_str(j_m)
    if (corr_sf_ACRE_sym(j_m) .ge. 0.3) then
      if (corr_sf_ACRE_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_ACRE_sym(m_number-1) = avg(corr_sf_ACRE_sym(1:))
  plot_sf_ACRE_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_ACRE_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_ACRE_sym(1:)) .ge. 0.3) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  

; wks = gsn_open_wks("png","lb")                   ; send graphics to PNG file

  ;wks_type = "eps"
  wks   = gsn_open_wks ("eps","Variances_E_budget")
  plot = new(10,graphic)

  res                       = True                 ; plot mods desired         
  ;res@gsnMaximize           = True                 ; maximize plot in frame
  res@gsnDraw               = False                ; don't draw plot yet
  res@gsnFrame              = False                ; don't advance frame yet

  res@trYMinF               = 0.                   ; bring bars down to zero
  res@trYMaxF               = 100.                   ; bring bars down to zero
  
  res@trXMinF               = min(x) - 1          ; adds space on either end
  res@trXMaxF               = max(x) + 1          ; of the 1st and last bars

  res@gsnXYBarChart         = True                 ; turn on bar chart
  res@gsnXYBarChartBarWidth = 0.65                 ; change bar widths
  res@gsnXYBarChartColors   = plot_bar_col
  
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tmXTOn                = False                ; turn off X tickmarks and labels
  res@tmYROn                = False                ; turn off X tickmarks and labels

  res@tmYLMode              = "Explicit"
  res@tmYLValues            = (/0.,20.,40.,60.,80.,100./)
  res@tmYLLabels            = (/"0","20","40","60","80","100"/)

  res@tiYAxisString         = " "
  ;res@tiYAxisString         = "Variance explained [%]"

  res@tmXBMode              = "Explicit"
  res@tmXBValues            = x
  res@tmXBLabels            = plot_sf_ACRE_str
  res@tmXBLabelAngleF       = 60.


  res@tmXBLabelJust = "TopRight"

  res@tiMainOffsetYF = -0.004


  ;vpw=0.8
  ;vph=0.8
  res@vpWidthF          = 0.9
  res@vpHeightF         = 0.2

  res@tiMainFont = 21
  res@tiMainFontHeightF = 0.022
  res@tiYAxisFont    = 21
  res@tiYAxisFontHeightF = 0.025 
  res@tiXAxisFont    = 21
  res@tiXAxisFontHeightF = 0.022

  res@tmYLLabelFontHeightF = 0.02 
  res@tmXBLabelFontHeightF = 0.02 


  res@tiMainFont = 21
  res@tiMainString = "a) Variance explained: F~B~~F5~w~F21~500>0~N~ and ACRE" 
  res@tiYAxisFont    = 21
  res@tiYAxisFontHeightF = 0.022 

 res@tmXBLabelsOn = False 
 res@tmYLLabelsOn = True


  ;printVarSummary(wks)

 res@gsnPanelBottom =0.1

  plot(0) = gsn_csm_xy (wks,x(:),100.*plot_sf_ACRE_sym(:),res)




 delete(plot_bar_col)

  plot_sf_RAD_sym = new(m_number,float)
  plot_sf_RAD_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_RAD_sym(j_m-1) = corr_sf_RAD_sym(j_m)
    plot_sf_RAD_str(j_m-1) = file_str(j_m)
    if (corr_sf_RAD_sym(j_m) .ge. 0.3) then
      if (corr_sf_RAD_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_RAD_sym(m_number-1) = avg(corr_sf_RAD_sym(1:))
  plot_sf_RAD_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_RAD_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_RAD_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "b) Variance explained: F~B~~F5~w~F21~500>0~N~ and Radiative Heating"
  res@tmXBOn       = True                 ;turn off X tickmarks and labels
  res@tmXBLabelsOn = False


  plot(2) = gsn_csm_xy (wks,x(:),100.*plot_sf_RAD_sym(:),res)
  






 delete(plot_bar_col)

  plot_sf_UPTAKE_sym = new(m_number,float)
  plot_sf_UPTAKE_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_UPTAKE_sym(j_m-1) = corr_sf_UPTAKE_sym(j_m)
    plot_sf_UPTAKE_str(j_m-1) = file_str(j_m)
    if (corr_sf_UPTAKE_sym(j_m) .ge. 0.3) then
      if (corr_sf_UPTAKE_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_UPTAKE_sym(m_number-1) = avg(corr_sf_UPTAKE_sym(1:))
  plot_sf_UPTAKE_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_UPTAKE_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_UPTAKE_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col

res@tiYAxisString         = "Variance explained [%]"
  res@tiMainString = "c) Variance explained: F~B~~F5~w~F21~500>0~N~ and Energy uptake"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels

  plot(4) = gsn_csm_xy (wks,x(:),100.*plot_sf_UPTAKE_sym(:),res)






 delete(plot_bar_col)

  plot_sf_TURB_sym = new(m_number,float)
  plot_sf_TURB_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_TURB_sym(j_m-1) = corr_sf_TURB_sym(j_m)
    plot_sf_TURB_str(j_m-1) = file_str(j_m)
    if (corr_sf_TURB_sym(j_m) .ge. 0.3) then
      if (corr_sf_TURB_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_TURB_sym(m_number-1) = avg(corr_sf_TURB_sym(1:))
  plot_sf_TURB_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_TURB_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_TURB_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "d) Variance explained: F~B~~F5~w~F21~500>0~N~ and Turbulent heat flux"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
res@tiYAxisString         = " "

  plot(6) = gsn_csm_xy (wks,x(:),100.*plot_sf_TURB_sym(:),res)







delete(plot_bar_col)

  plot_sf_delta_uptake_sym = new(m_number,float)
  plot_sf_delta_uptake_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_delta_uptake_sym(j_m-1) = corr_sf_delta_uptake_sym(j_m)
    plot_sf_delta_uptake_str(j_m-1) = file_str(j_m)
    if (corr_sf_delta_uptake_sym(j_m) .ge. 0.3) then
      if (corr_sf_delta_uptake_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_delta_uptake_sym(m_number-1) = avg(corr_sf_delta_uptake_sym(1:))
  plot_sf_delta_uptake_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_delta_uptake_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_delta_uptake_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "e) Variance explained: F~B~~F5~w~F21~500>0~N~ and Mer. grad. of energy uptake"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tmYLLabelsOn = True
  ;es@tiYAxisString         = "Variance explained [%]"
    res@tmXBLabelsOn = True


  plot(8) = gsn_csm_xy (wks,x(:),100.*plot_sf_delta_uptake_sym(:),res)
  





delete(plot_bar_col)

  plot_sf_top_sym = new(m_number,float)
  plot_sf_top_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)


  print(corr_sf_top_sym(:))

  do j_m=1,m_number-1
    plot_sf_top_sym(j_m-1) = corr_sf_top_sym(j_m)
    plot_sf_top_str(j_m-1) = file_str(j_m)
    if (corr_sf_top_sym(j_m) .ge. 0.3) then
      if (corr_sf_top_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_top_sym(m_number-1) = avg(corr_sf_top_sym(1:))
  plot_sf_top_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_top_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_top_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "f) Variance explained: F~B~~F5~w~F21~500>0~N~ and ~F5~G~B~w~F21~~N~"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tiYAxisString         = " "
  res@tmXBLabelsOn = False
  res@tmYLLabelsOn = False

  plot(1) = gsn_csm_xy (wks,x(:),100.*plot_sf_top_sym(:),res)





 
 delete(plot_bar_col)

  plot_sf_shallow_sym = new(m_number,float)
  plot_sf_shallow_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_shallow_sym(j_m-1) = corr_sf_shallow_sym(j_m)
    plot_sf_shallow_str(j_m-1) = file_str(j_m)
    if (corr_sf_shallow_sym(j_m) .ge. 0.3) then
      if (corr_sf_shallow_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_shallow_sym(m_number-1) = avg(corr_sf_shallow_sym(1:))
  plot_sf_shallow_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_shallow_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_shallow_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "g) Variance explained: F~B~~F5~w~F21~500>0~N~ and ~F5~S~B~w~F21~~N~"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels

  plot(3) = gsn_csm_xy (wks,x(:),100.*plot_sf_shallow_sym(:),res)




 delete(plot_bar_col)

  plot_sf_dphi_Ts_sym = new(m_number,float)
  plot_sf_dphi_Ts_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_dphi_Ts_sym(j_m-1) = corr_sf_dphi_Ts_sym(j_m)
    plot_sf_dphi_Ts_str(j_m-1) = file_str(j_m)
    if (corr_sf_dphi_Ts_sym(j_m) .ge. 0.3) then
      if (corr_sf_dphi_Ts_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_dphi_Ts_sym(m_number-1) = avg(corr_sf_dphi_Ts_sym(1:))
  plot_sf_dphi_Ts_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_dphi_Ts_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_dphi_Ts_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "h) Variance explained: F~B~~F5~w~F21~500>0~N~ and Mer. grad. of surface Temperature"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  ;res@tmYLLabelsOn = True

  plot(5) = gsn_csm_xy (wks,x(:),100.*plot_sf_dphi_Ts_sym(:),res)






delete(plot_bar_col)

  plot_sf_dphi_MSE_sym = new(m_number,float)
  plot_sf_dphi_MSE_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_dphi_MSE_sym(j_m-1) = corr_sf_dphi_MSE_sym(j_m)
    plot_sf_dphi_MSE_str(j_m-1) = file_str(j_m)
    if (corr_sf_dphi_MSE_sym(j_m) .ge. 0.3) then
      if (corr_sf_dphi_MSE_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_dphi_MSE_sym(m_number-1) = avg(corr_sf_dphi_MSE_sym(1:))
  plot_sf_dphi_MSE_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_dphi_MSE_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_dphi_MSE_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "i) Variance explained: F~B~~F5~w~F21~500>0~N~ and Mer. grad. of near-surface MSE"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels

  plot(7) = gsn_csm_xy (wks,x(:),100.*plot_sf_dphi_MSE_sym(:),res)





 delete(plot_bar_col)

  plot_sf_Ts_sym = new(m_number,float)
  plot_sf_Ts_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_sf_Ts_sym(j_m-1) = corr_sf_Ts_sym(j_m)
    plot_sf_Ts_str(j_m-1) = file_str(j_m)
    if (corr_sf_Ts_sym(j_m) .ge. 0.3) then
      if (corr_sf_Ts_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_sf_Ts_sym(m_number-1) = avg(corr_sf_Ts_sym(1:))
  plot_sf_Ts_str(m_number-1) = "Multi-model mean"

  if (avg(corr_sf_Ts_sym(1:)) .ge. 0.3) then
    if (avg(corr_sf_Ts_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "j) Variance explained: F~B~~F5~w~F21~500>0~N~ and Surface Temperature"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tmXBLabelsOn = True

  plot(9) = gsn_csm_xy (wks,x(:),100.*plot_sf_Ts_sym(:),res)



 resP=True

 resP@gsnPanelYWhiteSpacePercent = 0
 resP@gsnPanelXWhiteSpacePercent = 0

 resP@gsnPanelBottom = 0.07
 resP@gsnPanelLeft   = 0.03
 resP@gsnPanelRight  = 0.97


  gsn_panel(wks,plot,(/5,2/),resP)    








;==============================================================================================================================
delete(plot)
delete(wks)




  plot_cl_ACRE_sym = new(m_number,float)
  plot_cl_ACRE_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_ACRE_sym(j_m-1) = corr_cl_ACRE_sym(j_m)
    plot_cl_ACRE_str(j_m-1) = file_str(j_m)
    if (corr_cl_ACRE_sym(j_m) .ge. 0.3) then
      if (corr_cl_ACRE_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_ACRE_sym(m_number-1) = avg(corr_cl_ACRE_sym(1:))
  plot_cl_ACRE_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_ACRE_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_ACRE_sym(1:)) .ge. 0.3) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  

; wks = gsn_open_wks("png","lb")                   ; send graphics to PNG file

  ;wks_type = "eps"
  wks   = gsn_open_wks ("eps","Variances_cl_E_budget")
  plot = new(10,graphic)

  res                       = True                 ; plot mods desired         
  ;res@gsnMaximize           = True                 ; maximize plot in frame
  res@gsnDraw               = False                ; don't draw plot yet
  res@gsnFrame              = False                ; don't advance frame yet

  res@trYMinF               = 0.                   ; bring bars down to zero
  res@trYMaxF               = 100.                   ; bring bars down to zero
  
  res@trXMinF               = min(x) - 1          ; adds space on either end
  res@trXMaxF               = max(x) + 1          ; of the 1st and last bars

  res@gsnXYBarChart         = True                 ; turn on bar chart
  res@gsnXYBarChartBarWidth = 0.65                 ; change bar widths
  res@gsnXYBarChartColors   = plot_bar_col
  
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tmXTOn                = False                ; turn off X tickmarks and labels
  res@tmYROn                = False                ; turn off X tickmarks and labels

  res@tmYLMode              = "Explicit"
  res@tmYLValues            = (/0.,20.,40.,60.,80.,100./)
  res@tmYLLabels            = (/"0","20","40","60","80","100"/)

  res@tiYAxisString         = " "
  ;res@tiYAxisString         = "Variance explained [%]"

  res@tmXBMode              = "Explicit"
  res@tmXBValues            = x
  res@tmXBLabels            = plot_cl_ACRE_str
  res@tmXBLabelAngleF       = 60.


  res@tmXBLabelJust = "TopRight"

  res@tiMainOffsetYF = -0.004


  ;vpw=0.8
  ;vph=0.8
  res@vpWidthF          = 0.9
  res@vpHeightF         = 0.2

  res@tiMainFont = 21
  res@tiMainFontHeightF = 0.022
  res@tiYAxisFont    = 21
  res@tiYAxisFontHeightF = 0.025 
  res@tiXAxisFont    = 21
  res@tiXAxisFontHeightF = 0.022

  res@tmYLLabelFontHeightF = 0.02 
  res@tmXBLabelFontHeightF = 0.02 


  res@tiMainFont = 21
  res@tiMainString = "a) Variance explained: S~B~~F5~l~F21~~N~(P) and ACRE" 
  res@tiYAxisFont    = 21
  res@tiYAxisFontHeightF = 0.022 

 res@tmXBLabelsOn = False 
 res@tmYLLabelsOn = True


  ;printVarSummary(wks)

 res@gsnPanelBottom =0.1

  plot(0) = gsn_csm_xy (wks,x(:),100.*plot_cl_ACRE_sym(:),res)




 delete(plot_bar_col)

  plot_cl_RAD_sym = new(m_number,float)
  plot_cl_RAD_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_RAD_sym(j_m-1) = corr_cl_RAD_sym(j_m)
    plot_cl_RAD_str(j_m-1) = file_str(j_m)
    if (corr_cl_RAD_sym(j_m) .ge. 0.3) then
      if (corr_cl_RAD_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_RAD_sym(m_number-1) = avg(corr_cl_RAD_sym(1:))
  plot_cl_RAD_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_RAD_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_RAD_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "b) Variance explained: S~B~~F5~l~F21~~N~(P) and Radiative Heating"
  res@tmXBOn       = True                 ;turn off X tickmarks and labels
  res@tmXBLabelsOn = False


  plot(2) = gsn_csm_xy (wks,x(:),100.*plot_cl_RAD_sym(:),res)
  






 delete(plot_bar_col)

  plot_cl_UPTAKE_sym = new(m_number,float)
  plot_cl_UPTAKE_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_UPTAKE_sym(j_m-1) = corr_cl_UPTAKE_sym(j_m)
    plot_cl_UPTAKE_str(j_m-1) = file_str(j_m)
    if (corr_cl_UPTAKE_sym(j_m) .ge. 0.3) then
      if (corr_cl_UPTAKE_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_UPTAKE_sym(m_number-1) = avg(corr_cl_UPTAKE_sym(1:))
  plot_cl_UPTAKE_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_UPTAKE_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_UPTAKE_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col

res@tiYAxisString         = "Variance explained [%]"
  res@tiMainString = "c) Variance explained: S~B~~F5~l~F21~~N~(P) and Energy uptake"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels

  plot(4) = gsn_csm_xy (wks,x(:),100.*plot_cl_UPTAKE_sym(:),res)






 delete(plot_bar_col)

  plot_cl_TURB_sym = new(m_number,float)
  plot_cl_TURB_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_TURB_sym(j_m-1) = corr_cl_TURB_sym(j_m)
    plot_cl_TURB_str(j_m-1) = file_str(j_m)
    if (corr_cl_TURB_sym(j_m) .ge. 0.3) then
      if (corr_cl_TURB_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_TURB_sym(m_number-1) = avg(corr_cl_TURB_sym(1:))
  plot_cl_TURB_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_TURB_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_TURB_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "d) Variance explained: S~B~~F5~l~F21~~N~(P) and Turbulent heat flux"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
res@tiYAxisString         = " "

  plot(6) = gsn_csm_xy (wks,x(:),100.*plot_cl_TURB_sym(:),res)







delete(plot_bar_col)

  plot_cl_delta_uptake_sym = new(m_number,float)
  plot_cl_delta_uptake_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_delta_uptake_sym(j_m-1) = corr_cl_delta_uptake_sym(j_m)
    plot_cl_delta_uptake_str(j_m-1) = file_str(j_m)
    if (corr_cl_delta_uptake_sym(j_m) .ge. 0.3) then
      if (corr_cl_delta_uptake_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_delta_uptake_sym(m_number-1) = avg(corr_cl_delta_uptake_sym(1:))
  plot_cl_delta_uptake_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_delta_uptake_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_delta_uptake_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "e) Variance explained: S~B~~F5~l~F21~~N~(P) and Mer. grad. of energy uptake"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tmYLLabelsOn = True
  ;es@tiYAxisString         = "Variance explained [%]"
    res@tmXBLabelsOn = True


  plot(8) = gsn_csm_xy (wks,x(:),100.*plot_cl_delta_uptake_sym(:),res)
  





delete(plot_bar_col)

  plot_cl_top_sym = new(m_number,float)
  plot_cl_top_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)


  print(corr_cl_top_sym(:))

  do j_m=1,m_number-1
    plot_cl_top_sym(j_m-1) = corr_cl_top_sym(j_m)
    plot_cl_top_str(j_m-1) = file_str(j_m)
    if (corr_cl_top_sym(j_m) .ge. 0.3) then
      if (corr_cl_top_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_top_sym(m_number-1) = avg(corr_cl_top_sym(1:))
  plot_cl_top_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_top_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_top_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "f) Variance explained: S~B~~F5~l~F21~~N~(P) and ~F5~G~B~w~F21~~N~"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tiYAxisString         = " "
  res@tmXBLabelsOn = False
  res@tmYLLabelsOn = False

  plot(1) = gsn_csm_xy (wks,x(:),100.*plot_cl_top_sym(:),res)





 
 delete(plot_bar_col)

  plot_cl_shallow_sym = new(m_number,float)
  plot_cl_shallow_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_shallow_sym(j_m-1) = corr_cl_shallow_sym(j_m)
    plot_cl_shallow_str(j_m-1) = file_str(j_m)
    if (corr_cl_shallow_sym(j_m) .ge. 0.3) then
      if (corr_cl_shallow_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_shallow_sym(m_number-1) = avg(corr_cl_shallow_sym(1:))
  plot_cl_shallow_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_shallow_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_shallow_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "g) Variance explained: S~B~~F5~l~F21~~N~(P) and ~F5~S~B~w~F21~~N~"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels

  plot(3) = gsn_csm_xy (wks,x(:),100.*plot_cl_shallow_sym(:),res)




 delete(plot_bar_col)

  plot_cl_dphi_Ts_sym = new(m_number,float)
  plot_cl_dphi_Ts_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_dphi_Ts_sym(j_m-1) = corr_cl_dphi_Ts_sym(j_m)
    plot_cl_dphi_Ts_str(j_m-1) = file_str(j_m)
    if (corr_cl_dphi_Ts_sym(j_m) .ge. 0.3) then
      if (corr_cl_dphi_Ts_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_dphi_Ts_sym(m_number-1) = avg(corr_cl_dphi_Ts_sym(1:))
  plot_cl_dphi_Ts_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_dphi_Ts_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_dphi_Ts_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "h) Variance explained: S~B~~F5~l~F21~~N~(P) and Mer. grad. of surface Temperature"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  ;res@tmYLLabelsOn = True

  plot(5) = gsn_csm_xy (wks,x(:),100.*plot_cl_dphi_Ts_sym(:),res)






delete(plot_bar_col)

  plot_cl_dphi_MSE_sym = new(m_number,float)
  plot_cl_dphi_MSE_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_dphi_MSE_sym(j_m-1) = corr_cl_dphi_MSE_sym(j_m)
    plot_cl_dphi_MSE_str(j_m-1) = file_str(j_m)
    if (corr_cl_dphi_MSE_sym(j_m) .ge. 0.3) then
      if (corr_cl_dphi_MSE_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_dphi_MSE_sym(m_number-1) = avg(corr_cl_dphi_MSE_sym(1:))
  plot_cl_dphi_MSE_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_dphi_MSE_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_dphi_MSE_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "i) Variance explained: S~B~~F5~l~F21~~N~(P) and Mer. grad. of near-surface MSE"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels

  plot(7) = gsn_csm_xy (wks,x(:),100.*plot_cl_dphi_MSE_sym(:),res)





 delete(plot_bar_col)

  plot_cl_Ts_sym = new(m_number,float)
  plot_cl_Ts_str = new(m_number,string)
  plot_bar_col     = new((/m_number,4/),float)

  do j_m=1,m_number-1
    plot_cl_Ts_sym(j_m-1) = corr_cl_Ts_sym(j_m)
    plot_cl_Ts_str(j_m-1) = file_str(j_m)
    if (corr_cl_Ts_sym(j_m) .ge. 0.3) then
      if (corr_cl_Ts_sym(j_m) .ge. 0.5) then
         plot_bar_col(j_m-1,:) = rgba(14,:) ;green
      else
         plot_bar_col(j_m-1,:) = rgba(20,:) ;orange
      end if
    else
         plot_bar_col(j_m-1,:) = rgba(26,:) ;red
    end if

  end do

  plot_cl_Ts_sym(m_number-1) = avg(corr_cl_Ts_sym(1:))
  plot_cl_Ts_str(m_number-1) = "Multi-model mean"

  if (avg(corr_cl_Ts_sym(1:)) .ge. 0.3) then
    if (avg(corr_cl_Ts_sym(1:)) .ge. 0.5) then
      plot_bar_col(m_number-1,:) = rgba(14,:) ;green
    else
      plot_bar_col(m_number-1,:) = rgba(20,:) ;orange
    end if
  else
    plot_bar_col(m_number-1,:) = rgba(26,:) ;red
  end if

  delete(res@gsnXYBarChartColors)
  res@gsnXYBarChartColors   = plot_bar_col


  res@tiMainString = "j) Variance explained: S~B~~F5~l~F21~~N~(P) and Surface Temperature"
  res@tmXBOn                = True                 ;turn off X tickmarks and labels
  res@tmXBLabelsOn = True

  plot(9) = gsn_csm_xy (wks,x(:),100.*plot_cl_Ts_sym(:),res)



 resP=True

 resP@gsnPanelYWhiteSpacePercent = 0
 resP@gsnPanelXWhiteSpacePercent = 0

 resP@gsnPanelBottom = 0.07
 resP@gsnPanelLeft   = 0.03
 resP@gsnPanelRight  = 0.97


  gsn_panel(wks,plot,(/5,2/),resP)    




















; print(corr_sf_UPTAKE_sym)
; print(avg(corr_sf_UPTAKE_sym(:)))
; print(corr_sf_uptake_10_16_sym)
; print(avg(corr_sf_uptake_10_16_sym(:)))
; print(corr_sf_delta_uptake_sym)
; print(avg(corr_sf_delta_uptake_sym(:)))
 ;print(sign_sf_top_sym)












end
