
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
begin 


; Script used for Popp, Bony and Lutsko (2020): Weaker links between zonal convective clustering and
; ITCZ width in climate models than in observations, GRL
;
; Creates Figures 1 (or_AMIP_MEAN_VAR_CNRS.eps) and 2 (or_AMIP_comp_corr_regress.eps)
;
; Calculates necessary correlations and r^2 values used for Supplementary Tables S1, S2, S3, S4
;

file_names=new (19,string)
file_names(0)="GPCP"

file_names(1)="ACCESS1-3_rtoatm"
file_names(2)="bcc-csm1-1"
file_names(3)="BNU-ESM"
file_names(4)="CanAM4"

file_names(5)="CMCC-CM"
file_names(6)="CCSM4"
file_names(7)="CNRM-CM5"
file_names(8)="FGOALS-s2"

file_names(9)="GFDL-CM3_o"
file_names(10)="GFDL-HIRAM-C360_o"
file_names(11)="IPSL-CM5A-MR"
file_names(12)="MIROC5"

file_names(13)="MIROC-ESM"
file_names(14)="MPI-ESM-LR"
file_names(15)="MPI-ESM-MR"
file_names(16)="MRI-AGCM3-2S"

file_names(17)="MRI-CGCM3"
file_names(18)="NorESM1-M"


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


 trop_lat = 30.
 index_lat=15.
 eq_lat = 6.
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
 
  
  reg_line_cl_width = new(m_number ,float)
  corr_cl_width     = new(m_number ,float)

  reg_line_cl_ssl   = new(m_number ,float)
  corr_cl_ssl       = new(m_number ,float)

  corr_cl_width_sign     = new(m_number ,float)

  corr_cl_ssl_sign       = new(m_number ,float)




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

    min_subs_size_lat_rel_sym   = new(m_number ,float)
    mean_subs_size_lat_rel_sym   = new(m_number ,float)


  mean_subs_frac_sym  = new(m_number ,float)
  std_subs_frac_sym   = new(m_number ,float)  

  mean_double_sym  = new(m_number ,float)
  std_double_sym   = new(m_number ,float)

  mean_pr_E_sym  = new(m_number ,float)
  std_pr_E_sym   = new(m_number ,float)


  mean_omega500     = new(m_number ,float)
  mean_omega500_sym = new(m_number ,float)


  reg_line_cl_width_sym = new(m_number ,float)
  corr_cl_width_sym     = new(m_number ,float)

  reg_line_cl_ssl_sym   = new(m_number ,float)
  corr_cl_ssl_sym       = new(m_number ,float)

  reg_line_cl_sf_sym   = new(m_number ,float)
  corr_cl_sf_sym       = new(m_number ,float)

  reg_line_width_ssl_sym = new(m_number ,float)
  corr_width_ssl_sym     = new(m_number ,float) 

  corr_cl_width_sign_sym = new(m_number ,float)
  corr_cl_ssl_sign_sym   = new(m_number ,float)

  corr_cl_ssl_sign_sym   = new(m_number ,float)
  corr_sf_ssl_sign_sym   = new(m_number ,float)
  corr_width_ssl_sign_sym   = new(m_number ,float)

  reg_line_width_ssl_rel_sym = new(m_number ,float)
  corr_width_ssl_rel_sym     = new(m_number ,float)

  corr_ssl_ssl_rel_sym  = new(m_number ,float)


 corr_sf_width_sym     = new(m_number ,float)
 corr_sf_ssl_sym       = new(m_number ,float)
 reg_line_sf_width_sym = new(m_number ,float)
 reg_line_sf_ssl_sym   = new(m_number ,float)


 corr_cc_Ai_sym       = new(m_number ,float)
 corr_sf_Ai_sym       = new(m_number ,float)
 corr_widthpr_Ai_sym  = new(m_number ,float)
 corr_widthdyn_Ai_sym = new(m_number ,float)

 corr_sf_E_sym       = new(m_number ,float)
 corr_sf_double_sym  = new(m_number ,float)
 reg_line_sf_E_sym       = new(m_number ,float)
 reg_line_sf_double_sym  = new(m_number ,float)
 

 corr_cc_Ai       = new(m_number ,float)
 corr_sf_Ai       = new(m_number ,float)
 corr_widthpr_Ai  = new(m_number ,float)
 corr_widthdyn_Ai = new(m_number ,float)



  RMSE_cluster       = new (m_number ,float)
  RMSE_width_pr      = new (m_number ,float)
  RMSE_subs_size_lat = new (m_number ,float)
  RMSE_subs_frac     = new (m_number ,float)


  RMSE_cluster_sym  = new (m_number ,float)
  RMSE_width_pr_sym = new (m_number ,float)
  RMSE_subs_size_lat_sym = new (m_number ,float)
  RMSE_subs_frac_sym     = new (m_number ,float)
  RMSE_double_sym        = new (m_number ,float)
  RMSE_pr_E_sym          = new (m_number ,float)


  mean_pr_Ai  = new(m_number ,float)
  std_pr_Ai   = new(m_number ,float)
  RMSE_pr_Ai  = new (m_number ,float)

  mean_pr_Ai_sym  = new(m_number ,float)
  std_pr_Ai_sym   = new(m_number ,float)
  RMSE_pr_Ai_sym  = new (m_number ,float)

 month_counter = new (m_number ,float)
 month_counter_overlapp = new (m_number ,float)






;================================================================
;Define reference fields with GPCP and ERA-Interim



  file1     = addfile("../FILES_AMIP/pr_day_"+file_names(0)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r")
  file_m    = addfile("../FILES_AMIP/pr_day_"+file_names(0)+"_amip_r1i1p1_"+yearmonday+"_mm_ZM.nc","r")
  file_5    = addfile("../FILES_AMIP/pr_day_"+file_names(0)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_TM_mm.nc","r")

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
  GPCP_pr_S    = new(month_number,float)
  GPCP_pr_E    = new(month_number,float)

  GPCP_pr_E(:)      = file_5->pr(:,0,0)

  delete(file_5)   

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






  do j_lat=toint(2),toint(lat_number-2)
    if(lat(j_lat-1) .GE. -trop_lat .AND. lat(j_lat-2) .LT. -trop_lat) then
      l_ST = j_lat-1
    end if
    if(lat(j_lat-1) .GE. -crit_lat .AND. lat(j_lat-2) .LT. -crit_lat) then
      c_ST = j_lat-1
    end if

  if(lat(j_lat-1) .GE. -index_lat .AND. lat(j_lat-2) .LT. -index_lat) then
    i_ST = j_lat-1
   end if

   if(lat(j_lat-1) .GE. -eq_lat .AND. lat(j_lat-2) .LT. -eq_lat) then
    i_Seq = j_lat-1
   end if

   if(lat(j_lat-1) .GE. 0. .AND. lat(j_lat-2) .LT. 0.) then
     if (lat(j_lat-1) .EQ. 0.) then
       l_0 = j_lat-1
       l_0N = j_lat-1
       l_0S = j_lat-2
     else
       l_0N = j_lat-1
       l_0S = j_lat-2
     end if
   end if

   if(lat(j_lat) .GE. trop_lat .AND. lat(j_lat-1) .LT. trop_lat) then
     l_NT = j_lat-1
   end if

    if(lat(j_lat) .GE. crit_lat .AND. lat(j_lat-1) .LT. crit_lat) then
      c_NT = j_lat-1
    end if

    if(lat(j_lat) .GE. index_lat .AND. lat(j_lat-1) .LT. index_lat) then
    i_NT = j_lat-1
   end if

   if(lat(j_lat) .GE. eq_lat .AND. lat(j_lat-1) .LT. eq_lat) then
    i_Neq = j_lat-1
   end if

  end do

  do j_time=1,month_number
     ITCZ=c_ST + maxind(precip_mm(j_time-1,c_ST:c_NT))
    pr_Ii(j_time-1) = c_ST + maxind(precip_mm(j_time-1,c_ST:c_NT))

      s_max_ind = 0


      s_max_ind = 0

    if (lat(ITCZ) .GT. 0. ) then
    do j_lat= 1,(l_0N-c_ST)
     if ( precip_mm(j_time-1,l_0N-j_lat) .gt. precip_mm(j_time-1,l_0N-j_lat+1) .and. \
       precip_mm(j_time-1,l_0N-j_lat) .gt. precip_mm(j_time-1,l_0N-j_lat-11) ) then
       if (abs(lat(l_0N) - lat(l_0N-j_lat)) .GT. 1.) then
         if (s_max_ind .eq. 0) then
           lat_max = l_0N-j_lat
           s_max_ind = s_max_ind + 1
         else
           if (precip_mm(j_time-1,l_0N-j_lat) .gt. precip_mm(j_time-1,lat_max)) then
            lat_max = l_0N-j_lat
           end if
         end if
       end if
     end if
    end do
  else
    do j_lat = 1,(c_NT-l_0S)
      if ( precip_mm(j_time-1,l_0S+j_lat) .gt. precip_mm(j_time-1,l_0S+j_lat-1)   .and. \
          precip_mm(j_time-1,l_0S+j_lat) .gt. precip_mm(j_time-1,l_0S+j_lat+1)) then
        if (abs(lat(l_0S) - lat(l_0S+j_lat)) .GT. 1.) then
          if (s_max_ind .eq. 0) then
            lat_max = l_0S+j_lat
            s_max_ind = s_max_ind + 1
          else
            if (precip_mm(j_time-1,l_0S+j_lat) .gt. precip_mm(j_time-1,lat_max)) then
              lat_max = l_0S+j_lat
            end if
          end if
        end if
      end if
    end do
  end if

  if (s_max_ind .gt. 0) then
    GPCP_pr_S(j_time-1) = abs(doubletofloat(lat(ITCZ) - lat(lat_max)))
  else
    GPCP_pr_S(j_time-1) = 0.
  end if


  end do

  delete(c_ST)
  delete(c_NT)

  delete(l_ST)
  delete(l_NT)

  delete(i_ST)
  delete(i_NT)

  delete(i_Seq)
  delete(i_Neq)

  delete(l_0S)
  delete(l_0N)






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
  GPCP_pr_Ai_sym    = new(month_number,float)
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
  GPCP_pr_S_sym_sel                 = new((/month_number/),float)
  GPCP_pr_E_sym_sel                 = new((/month_number/),float)
  GPCP_pr_Ai_sym_sel                 = new((/month_number/),float)

  month_counter_CMIP=0
  do j_m=1,month_number
    if (abs(GPCP_pr_Ai(j_m-1)) .le. 0.4) then
      GPCP_tm_zonvar_eq_precip_m_sym_sel(j_m-1) = GPCP_tm_zonvar_eq_precip_m(j_m-1)
      GPCP_pr_Ei_sym_sel(j_m-1) = GPCP_pr_Ei(j_m-1)
      ERA_subs_size_lat_sym_sel(j_m-1) = ERA_subs_size_lat(j_m-1)
      ERA_subs_frac_tm_sym_sel(j_m-1) = ERA_subs_frac_tm(j_m-1)
      GPCP_pr_S_sym_sel(j_m-1) = GPCP_pr_S(j_m-1)
      GPCP_pr_E_sym_sel(j_m-1) = GPCP_pr_E(j_m-1)
      month_counter_CMIP = month_counter_CMIP + 1
      GPCP_pr_Ai_sym_sel(j_m-1) = GPCP_pr_Ai(j_m-1)
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

 

;month_counter(0)=tofloat(month_counter_CMIP)/month_number














;========================================================================================================




do j_f=1,m_number
  ;file1     = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r")
  ;file_m    = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_mm_ZM.nc","r")
  ;file_w500 = addfile("../FILES_AMIP/wap500_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_ZM.nc","r")

  file1     = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r")  ;precip, daily means, meridional mean from 6S to 6N
  file_m    = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_mm_ZM.nc","r")       ;precip, monthly means, zonal means
  file_5    = addfile("../FILES_AMIP/pr_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_TM_mm.nc","r") ;precip, monthly means, area mean from 6S to 6N

  file_w500 = addfile("../FILES_AMIP/wap500_Amon_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmon+"_mm_ZM.nc","r")     ; omega at 500hPa, monthly means, zonal means
  file_w500_hr = addfile("../FILES_AMIP/wap500_day/wap500_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_6S_6N_MERM.nc","r") ; omega at 500hPa, daily means, meridional mean from 6S to 6N
  

  lat=file_m->lat
  lat_number=dimsizes(lat)
 
  lon = file1->lon
  lon_number = dimsizes(lon)
 
  
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

    tm_zonvar_eq_precip_m(j_m-1) = avg(zonvar_eq_precip_m(j_m-1,:))
    tm_zonavg_eq_precip_m(j_m-1) = avg(zonavg_eq_precip_m(j_m-1,:))
  end do


;=====================================================================================================
;------------------------------------------------------------------------------------------------------
;======================================================================================================

  delete(zonvar_eq_precip_m)
  delete(zonavg_eq_precip_m)

  delete(zonvar_eq_precip)
  delete(zonavg_eq_precip)

  delete(precip_hr_eq)

  



  pr_Ii        = new(month_number,integer)
  pr_S         = new(month_number,float)

  l_0 = 0

  do j_lat=toint(2),toint(lat_number-2)
    if(lat(j_lat-1) .GE. -trop_lat .AND. lat(j_lat-2) .LT. -trop_lat) then 
      l_ST = j_lat-1
    end if
    if(lat(j_lat-1) .GE. -crit_lat .AND. lat(j_lat-2) .LT. -crit_lat) then 
      c_ST = j_lat-1
    end if
    
  if(lat(j_lat-1) .GE. -index_lat .AND. lat(j_lat-2) .LT. -index_lat) then 
    i_ST = j_lat-1
   end if

   if(lat(j_lat-1) .GE. -eq_lat .AND. lat(j_lat-2) .LT. -eq_lat) then 
    i_Seq = j_lat-1
   end if

   if(lat(j_lat-1) .GE. 0. .AND. lat(j_lat-2) .LT. 0.) then
     if (lat(j_lat-1) .EQ. 0.) then
       l_0 = j_lat-1
       l_0N = j_lat-1
       l_0S = j_lat-2 
     else
       l_0N = j_lat-1
       l_0S = j_lat-2 
     end if
   end if

   if(lat(j_lat) .GE. trop_lat .AND. lat(j_lat-1) .LT. trop_lat) then 
     l_NT = j_lat-1
   end if

    if(lat(j_lat) .GE. crit_lat .AND. lat(j_lat-1) .LT. crit_lat) then 
      c_NT = j_lat-1
    end if

    if(lat(j_lat) .GE. index_lat .AND. lat(j_lat-1) .LT. index_lat) then 
    i_NT = j_lat-1
   end if

   if(lat(j_lat) .GE. eq_lat .AND. lat(j_lat-1) .LT. eq_lat) then 
    i_Neq = j_lat-1
   end if

  end do

  do j_time=1,month_number
     ITCZ=c_ST + maxind(precip_mm(j_time-1,c_ST:c_NT))
    pr_Ii(j_time-1) = c_ST + maxind(precip_mm(j_time-1,c_ST:c_NT))

      s_max_ind = 0

    if (lat(ITCZ) .GT. 0. ) then
    do j_lat= 1,(l_0N-c_ST)
     if ( precip_mm(j_time-1,l_0N-j_lat) .gt. precip_mm(j_time-1,l_0N-j_lat+1) .and. \
       precip_mm(j_time-1,l_0N-j_lat) .gt. precip_mm(j_time-1,l_0N-j_lat-11) ) then
       if (abs(lat(l_0N) - lat(l_0N-j_lat)) .GT. 1.) then
         if (s_max_ind .eq. 0) then   
           lat_max = l_0N-j_lat
           s_max_ind = s_max_ind + 1
         else
           if (precip_mm(j_time-1,l_0N-j_lat) .gt. precip_mm(j_time-1,lat_max)) then
            lat_max = l_0N-j_lat
           end if
         end if
       end if
     end if   
    end do
  else
    do j_lat = 1,(c_NT-l_0S)
      if ( precip_mm(j_time-1,l_0S+j_lat) .gt. precip_mm(j_time-1,l_0S+j_lat-1)   .and. \
          precip_mm(j_time-1,l_0S+j_lat) .gt. precip_mm(j_time-1,l_0S+j_lat+1)) then
        if (abs(lat(l_0S) - lat(l_0S+j_lat)) .GT. 1.) then    
          if (s_max_ind .eq. 0) then
            lat_max = l_0S+j_lat
            s_max_ind = s_max_ind + 1
          else
            if (precip_mm(j_time-1,l_0S+j_lat) .gt. precip_mm(j_time-1,lat_max)) then
              lat_max = l_0S+j_lat
            end if
          end if
        end if
      end if  
    end do
  end if

  if (s_max_ind .gt. 0) then
    pr_S(j_time-1) = abs(doubletofloat(lat(ITCZ) - lat(lat_max)))
  else
    pr_S(j_time-1) = 0. 
  end if


  end do

  delete(c_ST)
  delete(c_NT)

  delete(l_ST)
  delete(l_NT)

  delete(i_ST)
  delete(i_NT)

  delete(i_Seq)
  delete(i_Neq)

  delete(l_0S)
  delete(l_0N)



 omega500_hr_tm = new ((/lon_number/),float)
 
 



 omega500_m_lat = new ((/month_number,lat_number/),float)
 subs_size_lat = new ((/month_number/),float)
 subs_size_lat_rel = new ((/month_number/),float)

 omega500_hr_eq = new ((/time_number,lon_number/),float)
 ;printVarSummary(omega500_m_lat)
 ;printVarSummary(file_w500->wap(:,0,:,0))





 ;print(j_f)
 ;print("../FILES_AMIP/wap500_day/wap500_day_"+file_names(j_f-1)+"_amip_r1i1p1_"+yearmonday+"_5S_5N_MERM.nc")
 ;printVarSummary(file_w500_hr->wap)
 ;printVarSummary(omega500_hr_eq)
 
 if (j_f .eq. 1) then
   ;printVarSummary(file_w500->w(:,0,:,0))
   ;printVarSummary(omega500_m_lat) 
   omega500_m_lat(:,:)= tofloat(864.*file_w500->w(:,0,:,0))
   omega500_hr_eq(:,:) = tofloat(864.*file_w500_hr->w(:,0,0,:))
 else
  ;printVarSummary(file_w500_hr->wap)
  ;printVarSummary(omega500_hr_eq)
  
   omega500_m_lat(:,:)= 864.*file_w500->wap(:,0,:,0)
   omega500_hr_eq(:,:) = 864.*file_w500_hr->wap(:,0,0,:)
 end if
; printVarSummary(lat)
; printVarSummary(omega500_m_lat)

do j_lon=1,lon_number
  omega500_hr_tm(j_lon-1) = avg(omega500_hr_eq(:,j_lon-1))
end do

mean_omega500(j_f-1) = avg(omega500_hr_tm(:))
delete(omega500_hr_tm)


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




  ;subs_size_lat(j_m-1)   = (abs(lat_south)+abs(lat_north))
  subs_size_lat(j_m-1)   = abs(lat_north-lat_south)
  ;subs_size_lat_2(j_m-1) = (abs(lat_south_2)+abs(lat_north_2))
  subs_size_lat_rel(j_m-1)=(abs(lat_south)+abs(lat_north))
  ;subs_size_lat_rel(j_m-1)= lat_south
  ;if (lat_south .gt. 0. .or. lat_north .lt. 0) then
  ;  one_IT

end do


delete(file_w500)
delete(file_w500_hr)
delete(pr_Ii)
delete(omega500_m_lat)





  ;subs_size_lat = new(month_number,float)
  

  pr_Ai        = new(month_number,float)
  pr_Ei        = new(month_number,float)

  pr_E         = new(month_number,float)
  ;pr_E(:)      = file_m->pr(:,71,0)
  pr_E(:)      = file_5->pr(:,0,0)

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


;=====================================================================================================
;------------------------------------------------------------------------------------------------------
;======================================================================================================

  tm_zonvar_eq_precip_m_sym_sel = new((/month_number/),float)
  pr_Ei_sym_sel                 = new((/month_number/),float)
  pr_E_sym_sel                  = new((/month_number/),float)
  pr_S_sym_sel                  = new((/month_number/),float)
  subs_size_lat_sym_sel         = new((/month_number/),float)
  subs_size_lat_rel_sym_sel         = new((/month_number/),float)
  subs_frac_tm_sym_sel          = new((/month_number/),float)
  pr_Ai_sym_sel                 = new((/month_number/),float)

  month_number_sym=0.
  month_number_sym_o=0.

  do j_m=1,month_number
    if (abs(pr_Ai(j_m-1)) .le. 0.4) then
      tm_zonvar_eq_precip_m_sym_sel(j_m-1) = tm_zonvar_eq_precip_m(j_m-1)
      pr_Ei_sym_sel(j_m-1) = pr_Ei(j_m-1)
      subs_size_lat_sym_sel(j_m-1) = subs_size_lat(j_m-1)
      subs_size_lat_rel_sym_sel(j_m-1) = subs_size_lat_rel(j_m-1)
      subs_frac_tm_sym_sel(j_m-1) = subs_frac_tm(j_m-1)
      pr_E_sym_sel(j_m-1) = pr_E(j_m-1)
      pr_S_sym_sel(j_m-1) = pr_S(j_m-1)
      pr_Ai_sym_sel(j_m-1) = pr_Ai(j_m-1)
      if (abs(GPCP_pr_Ai(j_m-1)) .le. 0.4) then
        month_number_sym_o=month_number_sym_o+1.
      end if
      month_number_sym=month_number_sym+1.
      
    end if
  end do


month_counter(j_f-1)=tofloat(month_number_sym);/month_number
month_counter_overlapp(j_f-1)=100.*(month_number_sym_o)/tofloat(month_number_sym)


  ;print("j_f= "+j_f)
  print("  ")
  print("  ")
  print(file_names(j_f-1)+":")
  print("  ")
  print("Min Value clustering:")
  print(min(tm_zonvar_eq_precip_m(:)))
  print("Max Value clustering:")
  print(max(tm_zonvar_eq_precip_m(:)))
  print("  ")
  print("Min Value Width (precip):")
  print(min(pr_Ei(:)))
  print("Max Value Width (precip):")
  print(max(pr_Ei(:)))
  print("  ")
  print("Min Value Width (dyn):")
  print(min(subs_size_lat(:)))
  print("Max Value Width (dyn):")
  print(max(subs_size_lat(:)))
  print("  ")  


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = subs_frac_tm(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),subs_frac_tm(:))

  reg_line_cl_width(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - subs frac")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 
 

  delete(corr_EDIV)
  delete(corr_mat_E) 





 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = pr_E(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),pr_E(:))


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Eq. precip")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 
 

  delete(corr_EDIV)
  delete(corr_mat_E) 


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = pr_S(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),pr_S(:))


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Double ITCZ")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 
 

  delete(corr_EDIV)
  delete(corr_mat_E) 






  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),pr_Ei(:))

  reg_line_cl_width(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  corr_cl_width(j_f-1)      = (corr_EDIV(1))^2
  corr_cl_width_sign(j_f-1) = corr_EDIV(1)*abs(corr_EDIV(1))

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = subs_size_lat(:)

  reg_E=regline(tm_zonvar_eq_precip_m(:),subs_size_lat(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2
  corr_cl_ssl_sign(j_f-1) = corr_EDIV(1)*abs(corr_EDIV(1))

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(pr_Ei(:),subs_size_lat(:))

  reg_line_cl_width(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Width (pr) - Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ") 

  ;corr_cl_width(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(subs_frac_tm(:),pr_Ei(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Width (pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  ;corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)





 
  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = subs_size_lat(:)

  reg_E=regline(subs_frac_tm(:),subs_size_lat(:))

  reg_line_cl_ssl(j_f-1) = reg_E


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: subs frac - Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)

  ;corr_cl_ssl(j_f-1) = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_cc_Ai(j_f-1)      = (corr_EDIV(1))

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_sf_Ai(j_f-1)      = (corr_EDIV(1))

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = pr_Ei(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_widthpr_Ai(j_f-1)      = (corr_EDIV(1))

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_widthdyn_Ai(j_f-1)      = (corr_EDIV(1))   
    
  delete(corr_EDIV)
  delete(corr_mat_E)
  







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
  
  RMSE_cluster (j_f-1)  = dim_rmsd(tm_zonvar_eq_precip_m(:),GPCP_tm_zonvar_eq_precip_m(:))
  RMSE_width_pr(j_f-1)  = dim_rmsd(pr_Ei(:),GPCP_pr_Ei(:))
  RMSE_subs_size_lat(j_f-1) = dim_rmsd(subs_size_lat(:),ERA_subs_size_lat(:))
  RMSE_subs_frac(j_f-1) = dim_rmsd(subs_frac_tm(:),ERA_subs_frac_tm(:))


  mean_pr_Ai(j_f-1) = avg(pr_Ai(:))
  std_pr_Ai(j_f-1) = stddev(pr_Ai(:))
  RMSE_pr_Ai(j_f-1)         = sqrt(sum((pr_Ai(:)-GPCP_pr_Ai(:))^2)/month_number_sym_o)

 print(" ")  
 print("Mean Value Clustering:")
 print(mean_cluster(j_f-1)-0.)
 print("Std Value Clustering:")
 print(std_cluster(j_f-1)-0.)
 print("RMSE clustering:")
 print(RMSE_cluster (j_f-1)-0.)


 print(" ")
 print("Mean Subsidence Fraction:")
 print(mean_subs_frac(j_f-1)-0.)
 print("Std Subsidence Fraction:")
 print(std_subs_frac(j_f-1)-0.)
 print("RMSE Subsidence Fraction")
 print(RMSE_subs_frac(j_f-1)-0.)



 print(" ")
 print("Mean Value Width (pr):")
 print(mean_width_pr(j_f-1)-0.)
 print("Std Value Width (pr):")
 print(std_width_pr(j_f-1)-0.)
 print("RMSE Width (pr):")
 print(RMSE_width_pr (j_f-1)-0.)


 print(" ")
 print("Mean Value Width (dyn):")
 print(mean_subs_size_lat(j_f-1)-0.)
 print("Std Value Width (dyn):")
 print(std_subs_size_lat(j_f-1)-0.)
 print("RMSE Width (dyn):")
 print(RMSE_subs_size_lat(j_f-1)-0.)





  print("  ")
  print("  ")
  print("Symmetric:")
  print("  ")
   print("Min Value clustering:")
  print(min(tm_zonvar_eq_precip_m_sym_sel(:)))
  print("Max Value clustering:")
  print(max(tm_zonvar_eq_precip_m_sym_sel(:)))
  print("  ")
  print("Min Value Width (precip):")
  print(min(pr_Ei_sym_sel(:)))
  print("Max Value Width (precip):")
  print(max(pr_Ei_sym_sel(:)))
  print("  ")
  print("Min Value Width (dyn):")
  print(min(subs_size_lat_sym_sel(:)))
  print("Max Value Width (dyn):")
  print(max(subs_size_lat_sym_sel(:)))
  print("  ")    
 




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = subs_frac_tm_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),subs_frac_tm_sym_sel(:))
 
  reg_line_cl_sf_sym(j_f-1) = reg_E
  

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - subs frac")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")
 
  corr_cl_sf_sym(j_f-1)      = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


 


 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = pr_E_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),pr_E_sym_sel(:))


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Eq. precip")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = pr_S_sym_sel(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),pr_S_sym_sel(:))


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Double ITCZ")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



   corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = 86400.*pr_E_sym_sel(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),86400.*pr_E_sym_sel(:))

  reg_line_sf_E_sym(j_f-1) = reg_E 

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Subs Frac - Eq. precip")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_sf_E_sym(j_f-1)      = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = pr_S_sym_sel(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),pr_S_sym_sel(:))

  reg_line_sf_double_sym(j_f-1) = reg_E 

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Subs Frac - Double ITCZ")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_sf_double_sym(j_f-1)      = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)






  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = pr_Ei(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),pr_Ei_sym_sel(:))

  reg_line_cl_width_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_cl_width_sym(j_f-1)      = (corr_EDIV(1))^2
  corr_cl_width_sign_sym(j_f-1) = (corr_EDIV(1))/abs(corr_EDIV(1))

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = subs_size_lat(:)

  reg_E=regline(tm_zonvar_eq_precip_m_sym_sel(:),subs_size_lat(:))

  reg_line_cl_ssl_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: std precip - Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")


  corr_cl_ssl_sym(j_f-1) = (corr_EDIV(1))^2
  corr_cl_ssl_sign_sym(j_f-1) = (corr_EDIV(1))/abs(corr_EDIV(1))
 
  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)







 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat_sym_sel(:)
  corr_mat_E(1,:) = pr_Ei_sym_sel(:)

  reg_E=regline(pr_Ei_sym_sel(:),subs_size_lat_sym_sel(:))

  reg_line_width_ssl_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Width (dyn) - Width (pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_width_ssl_sym(j_f-1) = (corr_EDIV(1))^2
  corr_width_ssl_sign_sym = corr_EDIV(1)/abs(corr_EDIV(1)) 
  ;corr_cl_width_sign_sym(j_f-1) = (corr_EDIV(1))*abs(corr_EDIV(1)) 

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)



corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat_rel_sym_sel(:)
  corr_mat_E(1,:) = pr_Ei_sym_sel(:)

  reg_E=regline(pr_Ei_sym_sel(:),subs_size_lat_rel_sym_sel(:))

  reg_line_width_ssl_rel_sym(j_f-1) = reg_E

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Width (dyn) diff - Width (pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_width_ssl_rel_sym(j_f-1) = (corr_EDIV(1))^2
  ;corr_cl_width_sign_sym(j_f-1) = (corr_EDIV(1))*abs(corr_EDIV(1)) 

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)




 corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat_rel_sym_sel(:)
  corr_mat_E(1,:) = subs_size_lat_sym_sel(:)


  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Width (dyn) - Width (dyn) diff")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
 

  corr_ssl_ssl_rel_sym(j_f-1) = (corr_EDIV(1))^2
  ;corr_cl_width_sign_sym(j_f-1) = (corr_EDIV(1))*abs(corr_EDIV(1)) 

  delete(corr_EDIV)
  delete(corr_mat_E)









  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = pr_Ei_sym_sel(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),pr_Ei_sym_sel(:))
  
  reg_line_sf_width_sym(j_f-1) = reg_E 

 
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Subs frac - Width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_sf_width_sym(j_f-1)      = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)






  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = subs_size_lat_sym_sel(:)

  reg_E=regline(subs_frac_tm_sym_sel(:),subs_size_lat_sym_sel(:))

  reg_line_sf_ssl_sym(j_f-1) = reg_E 

 
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Subs frac - Width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("Regression coefficient: ")
  print(reg_E-0.)
  print("  ")

  corr_sf_ssl_sym(j_f-1)      = (corr_EDIV(1))^2
  corr_sf_ssl_sign_sym(j_f-1) = corr_EDIV(1)/abs(corr_EDIV(1)) 

  delete(corr_EDIV)
  delete(corr_mat_E)
  delete(reg_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = tm_zonvar_eq_precip_m_sym_sel(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_cc_Ai_sym(j_f-1)      = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_frac_tm_sym_sel(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_sf_Ai_sym(j_f-1)      = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = pr_Ei_sym_sel(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_widthpr_Ai_sym(j_f-1)      = (corr_EDIV(1))^2

  delete(corr_EDIV)
  delete(corr_mat_E)


  corr_mat_E      = new((/2,month_number/),float)
  corr_mat_E(0,:) = subs_size_lat_sym_sel(:)
  corr_mat_E(1,:) = pr_Ai(:)
  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  corr_widthdyn_Ai_sym(j_f-1)      = (corr_EDIV(1))^2   
    
  delete(corr_EDIV)
  delete(corr_mat_E)
  
  

  min_cluster_sym(j_f-1)   = min(tm_zonvar_eq_precip_m_sym_sel(:))
  max_cluster_sym(j_f-1)   = max(tm_zonvar_eq_precip_m_sym_sel(:))
  mean_cluster_sym(j_f-1)  = avg(tm_zonvar_eq_precip_m_sym_sel(:))
  std_cluster_sym(j_f-1)   = stddev(tm_zonvar_eq_precip_m_sym_sel(:))
  delta_cluster_sym(j_f-1) = max_cluster_sym(j_f-1) - min_cluster_sym(j_f-1)

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

  min_subs_size_lat_rel_sym(j_f-1)   = min(abs(subs_size_lat_rel_sym_sel(:)))
  mean_subs_size_lat_rel_sym(j_f-1)  = avg(abs(subs_size_lat_rel_sym_sel(:)))

  mean_subs_frac_sym(j_f-1)  = avg(subs_frac_tm_sym_sel(:))
  std_subs_frac_sym(j_f-1)   = stddev(subs_frac_tm_sym_sel(:))
 

  mean_double_sym(j_f-1) = avg(pr_S_sym_sel(:))
  std_double_sym(j_f-1) = stddev(pr_S_sym_sel(:))

  mean_pr_E_sym(j_f-1) = avg(pr_E_sym_sel(:))
  std_pr_E_sym(j_f-1) = stddev(pr_E_sym_sel(:))

  mean_pr_Ai_sym(j_f-1) = avg(pr_Ai_sym_sel(:))
  std_pr_Ai_sym(j_f-1) = stddev(pr_Ai_sym_sel(:))



  RMSE_cluster_sym (j_f-1)      = sqrt(sum((tm_zonvar_eq_precip_m_sym_sel(:)-GPCP_tm_zonvar_eq_precip_m_sym_sel(:))^2)/month_number_sym_o)
  RMSE_width_pr_sym(j_f-1)      = sqrt(sum((pr_Ei_sym_sel(:)-GPCP_pr_Ei_sym_sel(:))^2)/month_number_sym_o)
  RMSE_subs_size_lat_sym(j_f-1) = sqrt(sum((subs_size_lat_sym_sel(:)-ERA_subs_size_lat_sym_sel(:))^2)/month_number_sym_o)
  RMSE_subs_frac_sym(j_f-1)     = sqrt(sum((subs_frac_tm_sym_sel(:)-ERA_subs_frac_tm_sym_sel(:))^2)/month_number_sym_o)
  RMSE_double_sym(j_f-1)        = sqrt(sum((pr_S_sym_sel(:)-GPCP_pr_S_sym_sel(:))^2)/month_number_sym_o)
  RMSE_pr_E_sym(j_f-1)          = sqrt(sum((pr_E_sym_sel(:)-GPCP_pr_E_sym_sel(:))^2)/month_number_sym_o)
  RMSE_pr_Ai_sym(j_f-1)         = sqrt(sum((pr_Ai_sym_sel(:)-GPCP_pr_Ai_sym_sel(:))^2)/month_number_sym_o)


  


 

 print(" ")
 print("Mean Value Clustering:")
 print(mean_cluster_sym(j_f-1)-0.)
 print("Std Value Clustering:")
 print(std_cluster_sym(j_f-1)-0.)
 print("RMSE clustering:")
 print(RMSE_cluster_sym(j_f-1)-0.)


 print(" ")
 print("Mean Subsidence Fraction:")
 print(mean_subs_frac_sym(j_f-1)-0.)
 print("Std Subsidence Fraction:")
 print(std_subs_frac_sym(j_f-1)-0.)
 print("RMSE Subsidence Fraction")
 print(RMSE_subs_frac_sym(j_f-1)-0.)
 


 print(" ")
 print("Mean Value Width (pr):")
 print(mean_width_pr_sym(j_f-1)-0.)
 print("Std Value Width (pr):")
 print(std_width_pr_sym(j_f-1)-0.)
 print("RMSE Width (pr):")
 print(RMSE_width_pr_sym(j_f-1)-0.)


 print(" ")
 print("Mean Value Width (dyn):")
 print(mean_subs_size_lat_sym(j_f-1)-0.)
 print("Std Value Width (dyn):")
 print(std_subs_size_lat_sym(j_f-1)-0.)
 print("RMSE Width (dyn):")
 print(RMSE_subs_size_lat_sym(j_f-1)-0.)



 
  print("----------------------------------------- ")
  print("----------------------------------------- ")



  delete(precip_mm_o_2)
  delete(precip_mm_o)
  delete(precip_mm)

  delete(pr_Ai)
  delete(pr_Ei)
  delete(pr_E)
  delete(pr_S)

  delete(pr_Ai_sym_sel)
  delete(pr_S_sym_sel)

  delete(tm_zonvar_eq_precip_m_sym_sel)

  delete(tm_zonvar_eq_precip_m)
  delete(tm_zonavg_eq_precip_m)

   delete(lat)
  delete(lat_number)
  delete(lon)
  delete(lon_number)

  delete(file1)
  delete(file_m)


  delete(time)
  delete(time_number)
  delete(utc_date)
  delete(month_change)
  delete(month_days)
  delete(days_since_start)
  delete(subs_size_lat)
  delete(subs_size_lat_sym_sel)

  delete(subs_frac_tm)
  delete(subs_frac_tm_sym_sel)


end do 












  print("  ")
  print("  ")

  print("----------------------------------------- ")
  print("----------------------------------------- ")

  print("  ")
  print("  ")


  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Mean Clustering")
  print("  ")
  print("----------------------------------------- ")
  print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
  





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster(1:)
  corr_mat_E(1,1:) = mean_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 

 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = mean_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_cluster(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_cluster(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_cluster(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

 



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = mean_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")





 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = mean_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")




 


print("----------------------------------------- ")
print("  ")
print ("Corrs: Std Clustering")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster(1:)
  corr_mat_E(1,1:) = std_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = std_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = std_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")




 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = std_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
 

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")


  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_cluster(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = std_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = std_cluster(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = std_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: RMSE clustering")
print("  ")
print("----------------------------------------- ")
print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster(1:)
  corr_mat_E(1,1:) = mean_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac(1:)
  corr_mat_E(1,1:) = RMSE_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = RMSE_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster(1:)
  corr_mat_E(1,1:) = mean_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster(1:)
  corr_mat_E(1,1:) = std_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_cluster(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Mean Subs Frac:")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = mean_subs_frac(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = mean_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
 


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_frac(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = mean_subs_frac(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = mean_subs_frac(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = mean_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)







print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Std Subs Frac:")
print("  ")
print("----------------------------------------- ")
print("  ")





 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = std_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)








print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = std_subs_frac(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = std_subs_frac(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = std_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: RMSE Subs Frac:")
print("  ")
print("----------------------------------------- ")
print("  ")




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = mean_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = std_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_subs_frac(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Mean width (precip):")
print("  ")
print("----------------------------------------- ")
print("  ")





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_width_pr(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_width_pr(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = mean_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = mean_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)







print("----------------------------------------- ")

   print("  ")
 

print("----------------------------------------- ")
print("  ")
print ("Corrs: Std width (precip):")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_width_pr(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = std_width_pr(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = std_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)









print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: RMSE width (precip):")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE width (precip) - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE width (precip) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = RMSE_width_pr(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE width (precip) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)








print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Mean width (dyn):")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat(:)
  corr_mat_E(1,:) = mean_subs_size_lat(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (dyn) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = mean_subs_size_lat(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (dyn) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Std width (dyn):")
print("  ")
print("----------------------------------------- ")
print("  ")




 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat(1:)
  corr_mat_E(1,1:) = std_subs_size_lat(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (dyn) - Std width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






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
  print ("Corrs: Mean Clustering")
  print("  ")
  print("----------------------------------------- ")
  print("  ")









  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)







print("----------------------------------------- ")

   print("  ")
  



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = mean_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)







print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = mean_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_cluster_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_cluster_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)








 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_cluster_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = mean_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean clustering - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Std Clustering")
print("  ")
print("----------------------------------------- ")
print("  ")






  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = std_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")






 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = std_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = std_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = std_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_cluster_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = std_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std clustering - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: RMSE clustering")
print("  ")
print("----------------------------------------- ")
print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = mean_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = mean_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = std_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_cluster_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE clustering - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)








print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Mean Subs Frac:")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = mean_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = mean_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs. frac - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Std Subs Frac:")
print("  ")
print("----------------------------------------- ")
print("  ")


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = std_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_subs_frac_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = std_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs. frac - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: RMSE Subs Frac:")
print("  ")
print("----------------------------------------- ")
print("  ")




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = mean_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = std_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_subs_frac_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE subs. frac - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)








print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Mean width (precip):")
print("  ")
print("----------------------------------------- ")
print("  ")





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_width_pr_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_width_pr_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = mean_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (precip) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Std width (precip):")
print("  ")
print("----------------------------------------- ")
print("  ")





  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_width_pr_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = std_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (precip) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)









print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: RMSE width (precip):")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE width (precip) - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE width (precip) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE width (precip) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)









print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Mean width (dyn):")
print("  ")
print("----------------------------------------- ")
print("  ")




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_subs_size_lat_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (dyn) - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")
 


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = mean_subs_size_lat_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (dyn) - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")
   print("  ")

print("----------------------------------------- ")
print("  ")
print ("Corrs: Std width (dyn):")
print("  ")
print("----------------------------------------- ")
print("  ")




 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = std_subs_size_lat_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE (dyn) - Std width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)













  print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Mean Double ITCZ")
  print("  ")
  print("----------------------------------------- ")
  print("  ")

  ;print(mean_double_sym(:))
  ;print(mean_cluster_sym(:))

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_double_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = mean_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = mean_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = mean_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_double_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_double_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_double_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = mean_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Double ITCZ - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






 print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Std Double ITCZ")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_double_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = std_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = std_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = std_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = std_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = std_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_double_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_double_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_double_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = std_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Double ITCZ - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





  print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: RMSE Double ITCZ")
  print("  ")
  print("----------------------------------------- ")
  print("  ")

  print(RMSE_double_sym(:))

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_double_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = RMSE_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = RMSE_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean RMSE ITCZ - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = RMSE_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = RMSE_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_double_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_double_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_double_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = RMSE_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = RMSE_double_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_double_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Double ITCZ - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)














  print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Mean Eq. Precip.")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_pr_E_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = mean_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = mean_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = mean_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_pr_E_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_pr_E_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_pr_E_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = mean_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean Eq. Precip. - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






 print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: Std Eq. Precip.")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_pr_E_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = std_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = std_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = std_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = std_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = std_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_pr_E_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_pr_E_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_pr_E_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = std_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = std_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Eq. Precip. - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





  print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: RMSE Eq. Precip.")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_pr_E_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = RMSE_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = RMSE_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = RMSE_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = RMSE_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_pr_E_sym(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_pr_E_sym(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_pr_E_sym(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = RMSE_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = RMSE_pr_E_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_pr_E_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Eq. Precip. - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





  print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: MEAN  Precip Asymm")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_pr_Ai(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = mean_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = mean_pr_Ai(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = mean_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = mean_pr_Ai(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_pr_Ai(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_pr_Ai(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_pr_Ai(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: MEAN Precip Asymm - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = mean_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: mean Precip Asymm - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = mean_pr_Ai(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: MEAN Precip Asymm - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)







  print("  ")
  print("----------------------------------------- ")
  print("  ")
  print ("Corrs: RMSE  Precip Asymm")
  print("  ")
  print("----------------------------------------- ")
  print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_pr_Ai_sym(:)
  corr_mat_E(1,:) = mean_cluster_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Mean Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_cluster_sym(:)
  corr_mat_E(1,:) = RMSE_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Spread Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_cluster_sym(1:)
  corr_mat_E(1,1:) = RMSE_pr_Ai(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - RMSE Clustering")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")

   print("  ")


 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_frac_sym(:)
  corr_mat_E(1,:) = RMSE_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Mean Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_frac_sym(:)
  corr_mat_E(1,:) = RMSE_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Std. Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_frac_sym(1:)
  corr_mat_E(1,1:) = RMSE_pr_Ai(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - RMSE Subs. Fraction")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_pr_Ai(:)
  corr_mat_E(1,:) = mean_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Mean width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = RMSE_pr_Ai(:)
  corr_mat_E(1,:) = std_width_pr_sym(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Std width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



 print("----------------------------------------- ")

  print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_pr_Ai(1:)
  corr_mat_E(1,1:) = RMSE_width_pr_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - RMSE width (precip)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")

   print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = mean_subs_size_lat_sym(:)
  corr_mat_E(1,:) = RMSE_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Mean width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("----------------------------------------- ")

   print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,:) = std_subs_size_lat_sym(:)
  corr_mat_E(1,:) = RMSE_pr_Ai(:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - Std. width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")

   print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = RMSE_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = RMSE_pr_Ai(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: RMSE Precip Asymm - RMSE width (dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



















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






  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_cl_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs frac - Cor. Conv Clust - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs frac - Cor. Conv Clust - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_cl_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs frac - Cor. Conv Clust - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs frac - Cor. Conv Clust - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)


print("  ")
print("----------------------------------------- ")
print("  ")
print("----------------------------------------- ")
print("  ")



 corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_sf_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs frac - Cor. SF - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_sf_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean subs frac - Cor. SF - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_sf_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs frac - Cor. SF - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_frac_sym(1:)
  corr_mat_E(1,1:) = corr_sf_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std subs frac - Cor. SF - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("  ")
print("----------------------------------------- ")
print("  ")
print("----------------------------------------- ")
print("  ")
print("----------------------------------------- ")
print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_cl_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean conv clust - Cor. Conv Clust - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean conv clust - Cor. Conv Clust - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")
print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_cl_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Conv clust - Cor. Conv Clust - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Conv clust - Cor. Conv Clust - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)






print("  ")
print("----------------------------------------- ")
print("  ")
print("----------------------------------------- ")
print("  ")
print("----------------------------------------- ")
print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_sf_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean conv clust - Cor. SF - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean conv clust - Cor. SF - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")
print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_cl_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Conv clust - Cor. SF - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_cluster_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std Conv clust - Cor. SF - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)





print("----------------------------------------- ")
print("  ")
print("----------------------------------------- ")
print("  ")
print("----------------------------------------- ")
print("  ")



  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = corr_cl_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (dyn) - Cor. Conv Clust - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = mean_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Mean width (dyn) - Cor. Conv Clust - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)




print("----------------------------------------- ")
print("  ")

  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = corr_cl_width_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (dyn) - Cor. Conv Clust - width(pr)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)



print("----------------------------------------- ")
print("  ")


  corr_mat_E      = new((/2,m_number/),float)
  corr_mat_E(0,1:) = std_subs_size_lat_sym(1:)
  corr_mat_E(1,1:) = corr_cl_ssl_sym(1:)

  corr_EDIV = covcorm(corr_mat_E,(/1,0/))
  print("Cor: Std width (dyn) - Cor. Conv Clust - width(dyn)")
  print((corr_EDIV(1))^2)
  print(corr_EDIV(1)/abs(corr_EDIV(1)))
  print("  ")

  delete(corr_EDIV)
  delete(corr_mat_E)







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




  ;print(mean_cluster_sym)
  
  ;print(mean_width_pr_sym)  

  ;print(mean_subs_size_lat_sym)


  ;print(reg_line_cl_width_sym)

  ;print(reg_line_cl_ssl_sym)


 ; print(corr_cl_width_sym)

 ; print(corr_cl_ssl_sym)



  ;print(std_cluster)

 


;========================================================================================================
 res_ep=True

  res_ep@tiMainFont = 21
  res_ep@tiMainFontHeightF = 0.025
  res_ep@tiYAxisFont    = 21
  res_ep@tiYAxisFontHeightF = 0.022 
  res_ep@tiXAxisString  = "Normalized StD of precipitaion"
  res_ep@tiYAxisString  = "P~B~E~N~ [mm day~S~-1~N~]"
  res_ep@tiXAxisFont    = 21
  res_ep@tiXAxisFontHeightF = 0.022

  res_ep@tiMainOffsetYF = -0.01
 
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


  res_ep@tmXBMajorOutwardLengthF = 0.0 ; draw major x-axis tickmarks inward
  res_ep@tmXBMinorOutwardLengthF = 0.0 ; draw minor x-axis tickmarks inward
  res_ep@tmYLMajorOutwardLengthF = 0.0 ; draw major y-axis tickmarks inward
  res_ep@tmYLMinorOutwardLengthF = 0.0 ; draw minor y-axis tickmarks inward 


  X_color= new(m_number+1,string)

  X_color(:)="black"
  X_color(0)="red" 
  X_color(10)="green4"
  X_color(16)="green4" 


 X_color(m_number)="blue" 

  res_ep@xyMarkerColors = X_color


  tx_id = True
  tx_id@txFontHeightF = 0.0175
  ;tx_id@txJust        = "TopLeft"
  tx_id@txPosXF=-0.00
  
  tx_id@txAngleF        = 45.
 
  


;===========================================================================================================
; Plots: Scatter plots

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"or_AMIP_comp_mean")
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

   ; txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)

  
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
  wks   = gsn_open_wks (wks_type,"or_AMIP_comp_std")
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

   ; txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
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
  wks   = gsn_open_wks (wks_type,"or_AMIP_comp_mean_std")
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

   ; txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
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
  wks   = gsn_open_wks (wks_type,"or_AMIP_comp_mean_corr")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number,m_number/),float)
  Y_vec = new ((/4,m_number,m_number/),float)


  X_string(0) = "StD Conv. clustering"
  X_string(1) = "StD Conv. clustering"
  X_string(2) = "Mean Conv. clustering (sym)"
  X_string(3) = "Mean Conv. clustering (sym)"


  Y_string(0) = "Corr. Mean clust - Mean width pr"
  Y_string(1) = "Corr. Mean clust - Mean width dyn"
  Y_string(2) = "Corr. Mean clust - Mean width pr"
  Y_string(3) = "Corr. Mean clust - Mean width dyn"


  
  do j_f=1,m_number
  ;  X_vec(0,j_f-1,j_f-1) = mean_cluster(j_f-1)
  ;  X_vec(1,j_f-1,j_f-1) = mean_cluster(j_f-1)
  ;  X_vec(2,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)
  ;  X_vec(3,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)

    X_vec(0,j_f-1,j_f-1) = std_subs_frac_sym(j_f-1)
    X_vec(1,j_f-1,j_f-1) = std_subs_frac_sym(j_f-1)
    X_vec(2,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
    
    Y_vec(0,j_f-1,j_f-1) = corr_cl_width_sym(j_f-1)
    Y_vec(1,j_f-1,j_f-1) = corr_cl_ssl_sym(j_f-1)
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

      ; txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
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




delete(plot)
delete(wks)

;=================================================================================================

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"or_AMIP_comp_corr_regres")
  plot = new(8,graphic)

  X_string = new (8,string)
  Y_string = new (8,string)
  main_string = new (8,string)

  X_vec = new ((/8,m_number+1,m_number+1/),float)
  Y_vec = new ((/8,m_number+1,m_number+1/),float)


  X_string(0) = "r~S~2~N~: Clustering (precip) - Clustering (dyn)"
  X_string(1) = "r~S~2~N~: Clustering (precip) - ITCZ Width (precip)"
  X_string(2) = "r~S~2~N~: Clustering (precip) - ITCZ Width (dyn)"
  X_string(3) = "r~S~2~N~: Clustering (dyn) - ITCZ Width (precip)"
  X_string(4) = "r~S~2~N~: Clustering (dyn) - ITCZ Width (dyn)"
  X_string(5) = "r~S~2~N~: ITCZ Width (precip) - ITCZ Width (dyn)"
  X_string(6) = "r~S~2~N~: Clustering (dyn) - Equatorial precip"
  X_string(7) = "r~S~2~N~: Clustering (dyn) - Double ITCZ"


  Y_string(0) = "Reg: Clustering (precip) - Clustering (dyn)"
  Y_string(1) = "Reg: Clustering (precip) - ITCZ Width (precip)"
  Y_string(2) = "Reg: Clustering (precip) - ITCZ Width (dyn) [~S~o~N~lat]"
  Y_string(3) = "Reg: Clustering (dyn) - ITCZ Width (precip)"
  Y_string(4) = "Reg: Clustering (dyn) - ITCZ Width (dyn)"
  Y_string(5) = "Reg: ITCZ Width (precip) - ITCZ Width (dyn) [~S~o~N~ lat]"
  Y_string(6) = "Reg: Clustering (dyn) - Eq. precip. [mm day~S~-1~N~]"
  Y_string(7) = "Reg: Clustering (dyn) - Double ITCZ [~S~o~N~lat]"


  main_string = (/"a)","b)","c)","d)","e)","f)","g","h"/)

 ; Y_string(0) = "Regres: Clust - Subs. Frac."
 ; Y_string(1) = "Regres: Clust - Mean width pr"
 ; Y_string(2) = "Regres: Clust - Mean width dyn"
 ; Y_string(3) = "Regres: Mean width pr - Mean width dyn"




print(corr_cl_width)
  
  do j_f=1,m_number
   ; X_vec(0,j_f-1,j_f-1) = corr_cl_width(j_f-1)
   ; X_vec(1,j_f-1,j_f-1) = corr_cl_ssl(j_f-1)
    X_vec(0,j_f-1,j_f-1) = corr_cl_sf_sym(j_f-1)
    X_vec(1,j_f-1,j_f-1) = corr_cl_width_sym(j_f-1)
    X_vec(2,j_f-1,j_f-1) = corr_sf_ssl_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = corr_sf_width_sym(j_f-1)
    X_vec(4,j_f-1,j_f-1) = corr_cl_ssl_sym(j_f-1)
    X_vec(5,j_f-1,j_f-1) = corr_width_ssl_sym(j_f-1)
    X_vec(6,j_f-1,j_f-1) = corr_sf_E_sym(j_f-1)
    X_vec(7,j_f-1,j_f-1) = corr_sf_double_sym(j_f-1)

   ; Y_vec(0,j_f-1,j_f-1) = reg_line_cl_width(j_f-1) ;-reg_line_cl_width(0)
   ; Y_vec(1,j_f-1,j_f-1) = reg_line_cl_ssl(j_f-1) ;-reg_line_cl_ssl(0)
    Y_vec(0,j_f-1,j_f-1) = reg_line_cl_sf_sym(j_f-1) ;-reg_line_cl_ssl_sym(0)
    Y_vec(1,j_f-1,j_f-1) = reg_line_cl_width_sym(j_f-1) ;-reg_line_cl_width_sym(0)
    Y_vec(2,j_f-1,j_f-1) = reg_line_cl_ssl_sym(j_f-1) ;-reg_line_cl_ssl_sym(0)
    Y_vec(3,j_f-1,j_f-1) = reg_line_sf_width_sym(j_f-1) ;-reg_line_cl_width_sym(0)
    Y_vec(4,j_f-1,j_f-1) = reg_line_sf_ssl_sym(j_f-1) ;-reg_line_cl_ssl_sym(0)
    Y_vec(5,j_f-1,j_f-1) = reg_line_width_ssl_sym(j_f-1) ;-reg_line_cl_width_sym(0)
    Y_vec(6,j_f-1,j_f-1) = reg_line_sf_E_sym(j_f-1)
    Y_vec(7,j_f-1,j_f-1) = reg_line_sf_double_sym(j_f-1)
  end do

    X_vec(0,m_number,m_number) = avg(corr_cl_sf_sym(1:))
    X_vec(1,m_number,m_number) = avg(corr_cl_width_sym(1:))
    X_vec(2,m_number,m_number) = avg(corr_cl_ssl_sym(1:))
    X_vec(3,m_number,m_number) = avg(corr_sf_width_sym(1:))
    X_vec(4,m_number,m_number) = avg(corr_sf_ssl_sym(1:))
    X_vec(5,m_number,m_number) = avg(corr_width_ssl_sym(1:))
    X_vec(6,m_number,m_number) = avg(corr_sf_E_sym(1:))
    X_vec(7,m_number,m_number) = avg(corr_sf_double_sym(1:))

    Y_vec(0,m_number,m_number) = avg(reg_line_cl_sf_sym(1:))
    Y_vec(1,m_number,m_number) = avg(reg_line_cl_width_sym(1:))
    Y_vec(2,m_number,m_number) = avg(reg_line_cl_ssl_sym(1:))
    Y_vec(3,m_number,m_number) = avg(reg_line_sf_width_sym(1:))
    Y_vec(4,m_number,m_number) = avg(reg_line_sf_ssl_sym(1:))
    Y_vec(5,m_number,m_number) = avg(reg_line_width_ssl_sym(1:))
    Y_vec(6,m_number,m_number) = avg(reg_line_sf_E_sym(1:))
    Y_vec(7,m_number,m_number) = avg(reg_line_sf_double_sym(1:))
  

  res_ep@tiMainOffsetYF = -0.005


  do j_p=1,8

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;if (j_p .ne. 4 .and. j_p .ne. 5) then
      res_ep@trXMaxF     = 1.
      res_ep@trXMinF     = 0.
    ;end if
    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    res_ep@tiMainString=main_string(j_p-1)

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    ;if (j_p .ne. 4 .and. j_p .ne. 5) then
    ;  delete(res_ep@trXMaxF)
    ;  delete(res_ep@trXMinF)
    ;end if
    

    ;txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
  end do

    res_ep@tiMainOffsetYF = -0.01
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 2
 resP@gsnPanelXWhiteSpacePercent = 4

  
  gsn_panel(wks,plot,(/4,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

  delete(plot)
  delete(wks)

;print(ERA_precip_mm(0,:))






;=================================================================================================

 wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"or_AMIP_mean_clust_corr")
  plot = new(4,graphic)

  X_string = new (4,string)
  Y_string = new (4,string)

  X_vec = new ((/4,m_number+1,m_number+1/),float)
  Y_vec = new ((/4,m_number+1,m_number+1/),float)


  X_string(0) = "Mean Subs. Fraction"
  X_string(1) = "Mean Subs. Fraction"
  X_string(2) = "Mean Subs. Fraction"
  X_string(3) = "Mean Subs. Fraction"


  Y_string(0) = "Corr Clust - Width pr"
  Y_string(1) = "Corr Clust - Width dyn"
  Y_string(2) = "Corr SF - Width pr"
  Y_string(3) = "Corr SF - Width dyn"




print(corr_cl_width)
  
  do j_f=1,m_number
   ; X_vec(0,j_f-1,j_f-1) = corr_cl_width(j_f-1)
   ; X_vec(1,j_f-1,j_f-1) = corr_cl_ssl(j_f-1)
    X_vec(0,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
    X_vec(1,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
    X_vec(2,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
   ; Y_vec(0,j_f-1,j_f-1) = reg_line_cl_width(j_f-1) ;-reg_line_cl_width(0)
   ; Y_vec(1,j_f-1,j_f-1) = reg_line_cl_ssl(j_f-1) ;-reg_line_cl_ssl(0)
    Y_vec(0,j_f-1,j_f-1) = corr_cl_width_sym(j_f-1) ;-reg_line_cl_ssl_sym(0)
    Y_vec(1,j_f-1,j_f-1) = corr_cl_ssl_sym(j_f-1) ;-reg_line_cl_width_sym(0)
    Y_vec(2,j_f-1,j_f-1) = corr_sf_width_sym(j_f-1) ;-reg_line_cl_ssl_sym(0)
    Y_vec(3,j_f-1,j_f-1) = corr_sf_ssl_sym(j_f-1) ;-reg_line_cl_width_sym(0)
  end do

    ;X_vec(0,m_number,m_number) = avg(corr_cl_sf_sym(1:))
    ;X_vec(1,m_number,m_number) = avg(corr_cl_width_sym(1:))
    ;X_vec(2,m_number,m_number) = avg(corr_cl_ssl_sym(1:))
    ;X_vec(3,m_number,m_number) = avg(corr_width_ssl_sym(1:))

    ;Y_vec(0,m_number,m_number) = avg(reg_line_cl_sf_sym(1:))
    ;Y_vec(1,m_number,m_number) = avg(reg_line_cl_width_sym(1:))
    ;Y_vec(2,m_number,m_number) = avg(reg_line_cl_ssl_sym(1:))
    ;Y_vec(3,m_number,m_number) = avg(reg_line_width_ssl_sym(1:)) 
  




  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    ;res_ep@trYMaxF     = 1.3
    ;res_ep@trYMinF     = 0.6

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    ;txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
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
  wks   = gsn_open_wks (wks_type,"or_AMIP_comp_clust_subsfrac")
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

    ;txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),tx_id)
  
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

delete(wks)
delete(plot)

wks_type = "eps"
  wks   = gsn_open_wks (wks_type,"or_AMIP_MEAN_VAR_CNRS")
  plot = new(4,graphic)

  delete(main_string)
  X_string    = new (4,string)
  Y_string    = new (4,string)
  main_string = new (4,string)

  X_vec = new ((/4,m_number+1,m_number+1/),float)
  Y_vec = new ((/4,m_number+1,m_number+1/),float)
  X_std = new ((/4,m_number+1,m_number+1/),float)
  Y_vec = new ((/4,m_number+1,m_number+1/),float)
  Y_std = new ((/4,m_number+1,m_number+1/),float)

  X_pos = new ((/4,m_number+1,m_number+1/),float)
  Y_pos = new ((/4,m_number+1,m_number+1/),float)


  X_string(0) = "Conv. clustering (precip)"
  X_string(1) = "Conv. clustering (dyn) "
  X_string(2) = "Conv. clustering (precip)"
  X_string(3) = "Conv. clustering (dyn)"
 
  Y_string(0) = "ITCZ width (precip)"
  Y_string(1) = "ITCZ width (precip)"
  Y_string(2) = "ITCZ width (dyn) [~S~o~N~ lat]"
  Y_string(3) = "ITCZ width (dyn) [~S~o~N~ lat]"

 main_string = (/"a)","b)","c)","d)"/) 
  
;mean_cluster_sym(0)=1.12
;mean_subs_frac_sym(0)=0.35
;mean_width_pr_sym(0)=0.84
;mean_subs_size_lat_sym(0)=27.5


  do j_f=1,m_number
    X_vec(0,j_f-1,j_f-1) = mean_cluster_sym(j_f-1)
    X_std(0,j_f-1,j_f-1) = std_cluster_sym(j_f-1)
    X_vec(3,j_f-1,j_f-1) = mean_subs_frac_sym(j_f-1)
    X_std(3,j_f-1,j_f-1) = std_subs_frac_sym(j_f-1)
    Y_vec(0,j_f-1,j_f-1) = mean_width_pr_sym(j_f-1)
    Y_std(0,j_f-1,j_f-1) = std_width_pr_sym(j_f-1)
    Y_vec(3,j_f-1,j_f-1) = mean_subs_size_lat_sym(j_f-1)
    Y_std(3,j_f-1,j_f-1) = std_subs_size_lat_sym(j_f-1)
  end do


   X_vec(0,m_number,m_number) = avg(mean_cluster_sym(:))
   X_std(0,m_number,m_number) = avg(std_cluster_sym(:))

   X_vec(3,m_number,m_number) = avg(mean_subs_frac_sym(:))
   X_std(3,m_number,m_number) = avg(std_subs_frac_sym(:))

   Y_vec(0,m_number,m_number) = avg(mean_width_pr_sym(:))
   Y_std(0,m_number,m_number) = avg(std_width_pr_sym(:))
  
   Y_vec(3,m_number,m_number) = avg(mean_subs_size_lat_sym(:))
   Y_std(3,m_number,m_number) = avg(std_subs_size_lat_sym(:))
  

   X_vec(2,:,:) = X_vec(0,:,:)
   X_std(2,:,:) = X_std(0,:,:)

   X_vec(1,:,:) = X_vec(3,:,:)
   X_std(1,:,:) = X_std(3,:,:)

   Y_vec(2,:,:) = Y_vec(3,:,:)
   Y_std(2,:,:) = Y_std(3,:,:)

   Y_vec(1,:,:) = Y_vec(0,:,:)
   Y_std(1,:,:) = Y_std(0,:,:)  

   




   X_pos(0,:,:) = X_vec(0,:,:)
   X_pos(1,:,:) = X_vec(1,:,:)

   Y_pos(0,:,:) = Y_vec(0,:,:)-0.006
   Y_pos(1,:,:) = Y_vec(1,:,:)-0.5

   X_pos(2,:,:) = X_pos(0,:,:)
   X_pos(1,:,:) = X_pos(3,:,:)
   Y_pos(2,:,:) = Y_pos(3,:,:)
   Y_pos(1,:,:) = Y_pos(0,:,:) 

   



  tx_id@txFontColor="red"
  tx_id@txFontOpacityF= 0.5 

 delete(res_ep@trXMaxF)
 delete(res_ep@trXMinF)


  do j_p=1,4

    res_ep@tiXAxisString  = X_string(j_p-1)
    res_ep@tiYAxisString  = Y_string(j_p-1)
    res_ep@tiMainString   = main_string(j_p-1)

    ;res_ep@trXMaxF     = 1.3
    ;res_ep@trXMinF     = 0.6

    if (j_p .eq. 1 .or. j_p .eq. 2) then
      res_ep@trYMaxF     = 1.15
      res_ep@trYMinF     = 0.65
    else
      res_ep@trYMaxF     = 20.
      res_ep@trYMinF     = 38.
    end if

    plot(j_p-1)=gsn_csm_xy(wks,X_vec(j_p-1,:,:),Y_vec(j_p-1,:,:),res_ep)

    ;txid = gsn_add_text(wks,plot(j_p-1),labels(j_p-1,:,:),X_pos(j_p-1,:,:),Y_pos(j_p-1,:,:),tx_id)

    if (j_p .eq. 1 .or. j_p .eq. 2) then
      delete(res_ep@trYMaxF)
      delete(res_ep@trYMinF)
    else
      delete(res_ep@trYMaxF)
      delete(res_ep@trYMinF)
    end if
  
  end do


  lnres = True
  ;colors  = (/"red","purple","red","blue","brown","green"/)
  colors  = new(m_number+1,string)

  colors(:) ="black"
  colors(0) ="red"
  colors(10) ="green4"
  colors(16) ="green4"

  lnres@gsLineColor=colors

  ;nvalues = dimsizes(yvalues)

;lnid =gsn_add_polyline(wks,plot(0),(/1.12-0.13,1.12+0.13/),(/0.84,0.84/),lnres)
;lnid2 =gsn_add_polyline(wks,plot(0),(/1.12,1.12/),(/0.84-0.1,0.84+0.1/),lnres)


 lnid  = new(m_number+1,graphic)
 lnid2 = new(m_number+1,graphic)
 lnid3  = new(m_number+1,graphic)
 lnid4 = new(m_number+1,graphic)

 lnid5  = new(m_number+1,graphic)
 lnid6 = new(m_number+1,graphic)
 lnid7  = new(m_number+1,graphic)
 lnid8 = new(m_number+1,graphic)

 do j_f=1,m_number+1
   ;lnid(j_f-1) =gsn_add_polyline(wks,plot(0),(/mean_cluster_sym(j_f-1)-std_cluster_sym(j_f-1),mean_cluster_sym(j_f-1)+std_cluster_sym(j_f-1)/),\
   ;                                    (/mean_width_pr_sym(j_f-1),mean_width_pr_sym(j_f-1)/),lnres)
   ;lnid2(j_f-1) =gsn_add_polyline(wks,plot(0),(/mean_cluster_sym(j_f-1),mean_cluster_sym(j_f-1)/),(/mean_width_pr_sym(j_f-1)-std_width_pr_sym(j_f-1),\
   ;                                    mean_width_pr_sym(j_f-1)+std_width_pr_sym(j_f-1)/),lnres)
   ;
   ;lnid3(j_f-1) =gsn_add_polyline(wks,plot(1),(/mean_subs_frac_sym(j_f-1)-std_subs_frac_sym(j_f-1),mean_subs_frac_sym(j_f-1)+std_subs_frac_sym(j_f-1)/),\
   ;                                    (/mean_subs_size_lat_sym(j_f-1),mean_subs_size_lat_sym(j_f-1)/),lnres)
   ;lnid4(j_f-1) =gsn_add_polyline(wks,plot(1),(/mean_subs_frac_sym(j_f-1),mean_subs_frac_sym(j_f-1)/),(/mean_subs_size_lat_sym(j_f-1)-std_subs_size_lat_sym(j_f-1),\
   ;                                    mean_subs_size_lat_sym(j_f-1)+std_subs_size_lat_sym(j_f-1)/),lnres)


   lnid(j_f-1) =gsn_add_polyline(wks,plot(0),(/X_vec(0,j_f-1,j_f-1)-X_std(0,j_f-1,j_f-1),X_vec(0,j_f-1,j_f-1)+X_std(0,j_f-1,j_f-1)/),\
                                       (/Y_vec(0,j_f-1,j_f-1),Y_vec(0,j_f-1,j_f-1)/),lnres)
   lnid2(j_f-1) =gsn_add_polyline(wks,plot(0),(/X_vec(0,j_f-1,j_f-1),X_vec(0,j_f-1,j_f-1)/),(/Y_vec(0,j_f-1,j_f-1)-Y_std(0,j_f-1,j_f-1),\
                                       Y_vec(0,j_f-1,j_f-1)+Y_std(0,j_f-1,j_f-1)/),lnres)

   lnid3(j_f-1) =gsn_add_polyline(wks,plot(1),(/X_vec(1,j_f-1,j_f-1)-X_std(1,j_f-1,j_f-1),X_vec(1,j_f-1,j_f-1)+X_std(1,j_f-1,j_f-1)/),\
                                       (/Y_vec(1,j_f-1,j_f-1),Y_vec(1,j_f-1,j_f-1)/),lnres)
   lnid4(j_f-1) =gsn_add_polyline(wks,plot(1),(/X_vec(1,j_f-1,j_f-1),X_vec(1,j_f-1,j_f-1)/),(/Y_vec(1,j_f-1,j_f-1)-Y_std(1,j_f-1,j_f-1),\
                                       Y_vec(1,j_f-1,j_f-1)+Y_std(1,j_f-1,j_f-1)/),lnres)

   lnid5(j_f-1) =gsn_add_polyline(wks,plot(2),(/X_vec(2,j_f-1,j_f-1)-X_std(2,j_f-1,j_f-1),X_vec(2,j_f-1,j_f-1)+X_std(2,j_f-1,j_f-1)/),\
                                       (/Y_vec(2,j_f-1,j_f-1),Y_vec(2,j_f-1,j_f-1)/),lnres)
   lnid6(j_f-1) =gsn_add_polyline(wks,plot(2),(/X_vec(2,j_f-1,j_f-1),X_vec(2,j_f-1,j_f-1)/),(/Y_vec(2,j_f-1,j_f-1)-Y_std(2,j_f-1,j_f-1),\
                                       Y_vec(2,j_f-1,j_f-1)+Y_std(2,j_f-1,j_f-1)/),lnres)

   lnid7(j_f-1) =gsn_add_polyline(wks,plot(3),(/X_vec(3,j_f-1,j_f-1)-X_std(3,j_f-1,j_f-1),X_vec(3,j_f-1,j_f-1)+X_std(3,j_f-1,j_f-1)/),\
                                       (/Y_vec(3,j_f-1,j_f-1),Y_vec(3,j_f-1,j_f-1)/),lnres)
   lnid8(j_f-1) =gsn_add_polyline(wks,plot(3),(/X_vec(3,j_f-1,j_f-1),X_vec(3,j_f-1,j_f-1)/),(/Y_vec(3,j_f-1,j_f-1)-Y_std(3,j_f-1,j_f-1),\
                                       Y_vec(3,j_f-1,j_f-1)+Y_std(3,j_f-1,j_f-1)/),lnres)
   
   
   colors(0) ="black"
   lnres@gsLineColor=colors

   if (j_f .eq. m_number) then
     colors(0) ="blue"
     lnres@gsLineColor=colors      
   end if

   if (j_f .eq. 10) then
     colors(0) ="green4"
     lnres@gsLineColor=colors
   end if

   if (j_f .eq. 16) then
     colors(0) ="green4"
     lnres@gsLineColor=colors
   end if


 end do

; print(X_vec(0,0,0))
; print(X_std(0,0,0))
; print(X_vec(1,0,0))
; print(X_std(1,0,0))
 
; print(Y_vec(0,0,0))
; print(Y_std(0,0,0))
; print(Y_vec(1,0,0))
; print(Y_std(1,0,0))

;
; First way to add lines, using gsn_polyline.
;
;  lnres = True
;  do i=0,nvalues-1
;    lnres@gsLineColor = colors(i)
;    gsn_polyline(wks,plot(0),xvalues,(/yvalues(i),yvalues(i)/),lnres)
;  end do




;  print(mean_cluster_sym(0))
;  print(mean_subs_frac_sym(0))
;  print(mean_width_pr_sym(0))
;  print(mean_subs_size_lat_sym(0))
  
 
 resP                 = True
 resP@gsnPanelYWhiteSpacePercent = 3
 resP@gsnPanelXWhiteSpacePercent = 7

  
  gsn_panel(wks,plot,(/2,2/),resP)    

  delete(X_string)
  delete(Y_string)

  delete(X_vec)
  delete(Y_vec)

;print(ERA_precip_mm(0,:))




print(month_counter)
print(avg(month_counter(1:)))
print(month_counter_overlapp)
print(avg(month_counter_overlapp(1:)))

print("Corr conv clust - asymm:")
print(corr_cc_Ai_sym)

print("Corr subs frac - asymm:")
print(corr_sf_Ai_sym)

print("Corr width dyn - asymm:")
print(corr_widthdyn_Ai_sym)

print("Corr width pr - asymm:")
print(corr_widthpr_Ai_sym)


print(mean_omega500)





;print(corr_sf_double_sym)
;print(avg(corr_sf_double_sym(1:)))



print(corr_width_ssl_rel_sym)
print(avg(corr_width_ssl_rel_sym))

print(corr_ssl_ssl_rel_sym)
print(avg(corr_ssl_ssl_rel_sym))



print(min_subs_size_lat_sym/mean_subs_size_lat_sym)
print(avg(min_subs_size_lat_sym/mean_subs_size_lat_sym))

;print(max_subs_size_lat_sym)
;print(mean_subs_size_lat_sym)

;print(min_subs_size_lat_rel_sym)
;print(mean_subs_size_lat_rel_sym)


 ;print(mean_subs_size_lat_sym)
 ;print(std_subs_size_lat_sym)
 ;print(RMSE_subs_size_lat_sym)
 print(file_names)


 ;print(avg(mean_subs_size_lat_sym(1:)))
 ;print(avg(std_subs_size_lat_sym(1:)))
 ;print(avg(RMSE_subs_size_lat_sym(1:)))



;print(corr_cl_ssl_sym)
;print(corr_sf_ssl_sym)
;print(corr_width_ssl_sym)
;
;print(avg(corr_cl_ssl_sign_sym(1:)*corr_cl_ssl_sym(1:)))
;print(avg(corr_sf_ssl_sign_sym(1:)*corr_sf_ssl_sym(1:)))
;print(avg(corr_width_ssl_sign_sym(1:)*corr_width_ssl_sym(1:)))
;
;print(corr_cl_ssl_sign_sym)
;print(corr_sf_ssl_sign_sym)
;print(corr_width_ssl_sign_sym)

;print(reg_line_cl_ssl_sym)
;print(reg_line_sf_ssl_sym)
;print(reg_line_width_ssl_sym)
;
;print(avg(reg_line_cl_ssl_sym(1:)))
;print(avg(reg_line_sf_ssl_sym(1:)))
;print(avg(reg_line_width_ssl_sym(1:)))



end
