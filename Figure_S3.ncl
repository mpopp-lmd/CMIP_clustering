

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
begin 


; Script used for Popp, Bony and Lutsko (2020): Weaker links between zonal convective clustering and ITCZ width in climate models than in observations, GRL
;
;Creates Figure S3 (Variances_sortde.eps)
;
;The vlaues of thevariances for var_exp are obtained from the script:
; Figures_1_and_2.ncl


var_exp= new(32,float)


var_exp(0)	=0.8046858
var_exp(1)	=0.7257833
var_exp(2)	=0.7188336
var_exp(3)	=0.7085437
var_exp(4)	=0.7033858
var_exp(5)	=0.6948979
var_exp(6)	=0.682939
var_exp(7)	=0.6329201
var_exp(8)	=0.6007776
var_exp(9)	=0.5751919
var_exp(10)	=0.5669287
var_exp(11)	=0.5645934
var_exp(12)	=0.5620567
var_exp(13)	=0.5269258
var_exp(14)	=0.4955894
var_exp(15)	=0.4748229
var_exp(16)	=0.4671942
var_exp(17)	=0.4647515
var_exp(18)	=0.4410065
var_exp(19)	=0.4404831
var_exp(20)	=0.424231
var_exp(21)	=0.4068173
var_exp(22)	=0.3943414
var_exp(23)	=0.3829935
var_exp(24)	=0.3644626
var_exp(25)	=0.3588702
var_exp(26)	=0.346846
var_exp(27)	=0.3104228
var_exp(28)	=0.3081389
var_exp(29)	=0.3072598
var_exp(30)	=0.3047238
var_exp(31)	=0.3000089


var_str= new(32,string)


;var_str(0)="~F26~M~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(1)="~F26~M~F25~(P~B~E~N~) - ~F26~M~F25~(W~B~P~N~)"
;var_str(2)="~F26~M~F25~(S~B~~F5~l~F25~~N~(P)) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(3)="~F26~M~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(W~B~P~N~)"
;var_str(4)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(5)="~F26~R~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
;var_str(6)="~F26~M~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
;var_str(7)="~F26~M~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
;var_str(8)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(9)="~F26~M~F25~(S~B~~F5~l~F25~~N~(P)) - ~F26~M~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(10)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(S~B~~F5~l~F25~~N~(P))"
;var_str(11)="~F26~S~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(12)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(13)="~F26~M~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~P~N~)"
;var_str(14)="~F26~R~F25~(P~B~E~N~) - ~F26~M~F25~(W~B~P~N~)"
;var_str(15)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(16)="~F26~M~F25~(P~B~E~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
;var_str(17)="~F26~S~F25~(W~B~~F5~w~F25~~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
;var_str(18)="~F26~M~F25~(P~B~E~N~) - ~F26~R~F25~(W~B~P~N~)"
;var_str(19)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(20)="~F26~S~F25~(P~B~E~N~) - ~F26~M~F25~(W~B~~F5~w~F25~~N~)"
;var_str(21)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(22)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(W~B~P~N~)"
;var_str(23)="~F26~M~F25~(P~B~E~N~) - ~F26~S~F25~(W~B~P~N~)"
;var_str(24)="~F26~R~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~R~F25~(W~B~P~N~)"
;var_str(25)="~F26~M~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(26)="~F26~M~F25~(W~B~P~N~) -  ~F26~S~F25~(W~B~P~N~)"
;var_str(27)="~F26~M~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(W~B~P~N~)"
;var_str(28)="~F26~M~F25~(S~B~~F5~l~F25~~N~(P)) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
;var_str(29)="~F26~S~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~P~N~)"



var_str(0)="~F26~M~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(1)="~F26~M~F25~(P~B~E~N~) - ~F26~M~F25~(W~B~P~N~)"
var_str(2)="~F26~M~F25~(S~B~~F5~l~F25~~N~(P)) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(3)="~F26~M~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(W~B~P~N~)"
var_str(4)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(5)="~F26~R~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
var_str(6)="~F26~S~F25~(W~B~~F5~w~F25~~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
var_str(7)="~F26~M~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
var_str(8)="~F26~M~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
var_str(9)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(10)="~F26~M~F25~(S~B~~F5~l~F25~~N~(P)) - ~F26~M~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(11)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(S~B~~F5~l~F25~~N~(P))"
var_str(12)="~F26~S~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(13)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(14)="~F26~M~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~P~N~)"
var_str(15)="~F26~R~F25~(P~B~E~N~) - ~F26~M~F25~(W~B~P~N~)"
var_str(16)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~M~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(17)="~F26~M~F25~(P~B~E~N~) - ~F26~R~F25~(W~B~~F5~w~F25~~N~)"
var_str(18)="~F26~M~F25~(P~B~E~N~) - ~F26~R~F25~(W~B~P~N~)"
var_str(19)="~F26~R~F25~(W~B~P~N~) - ~F26~S~F25~(W~B~~F5~w~F25~~N~)"
var_str(20)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(21)="~F26~S~F25~(~F5~j~F25~~B~S~N~) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(22)="~F26~R~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(W~B~P~N~)"
var_str(23)="~F26~M~F25~(P~B~E~N~) - ~F26~S~F25~(W~B~P~N~)"
var_str(24)="~F26~R~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~R~F25~(W~B~P~N~)"
var_str(25)="~F26~S~F25~(P~B~E~N~) - ~F26~M~F25~(W~B~~F5~w~F25~~N~)"
var_str(26)="~F26~M~F25~(F~B~~F5~w~F25~500>0~N~) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(27)="~F26~M~F25~(W~B~P~N~) -  ~F26~S~F25~(W~B~P~N~)"
var_str(28)="~F26~M~F25~(~F5~j~F25~~B~S~N~) - ~F26~R~F25~(W~B~P~N~)"
var_str(29)="~F26~M~F25~(~F5~j~F25~~B~S~N~) - ~F26~S~F25~(W~B~~F5~w~F25~~N~)"
var_str(30)="~F26~M~F25~(S~B~~F5~l~F25~~N~(P)) - ~F26~S~F25~(F~B~~F5~w~F25~500>0~N~)"
var_str(31)="~F26~S~F25~(W~B~P~N~) - ~F26~R~F25~(W~B~P~N~)"






;=================================================================================================
; Bar plot for correlations



  ;lbres                    = True          ; labelbar only resources
  ;lbres@lbAutoManage       = True          ; Necessary to control sizes
  ;lbres@vpWidthF           = 0.2 * vpw     ; labelbar width
  ;lbres@vpHeightF          = 0.7 * vph     ; labelbar height
  ;lbres@lbBoxMajorExtentF  = 0.85          ; puts space between color boxes
  ;lbres@lbFillColors       = colors(::-1,:)        ; labelbar colors
  ;lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  ;lbres@lbLabelFontHeightF = 0.08          ; font height. default is small
  ;lbres@lbLabelJust        = "CenterLeft"  ; left justify labels
  ;lbres@lbLabelAutoStride  = False
  ;lbres@lbLabelStride      = 1
  ;lbres@lbFillOpacityF     = opacity_value
  ;
  ;lbid = gsn_create_labelbar(wks,nboxes,labels(::-1),lbres)
  ;            
  ;amres                  = True
  ;amres@amJust           = "TopRight"
  ;amres@amParallelPosF   =  0.4
  ;amres@amOrthogonalPosF = -0.5
  ;plot@annoid = gsn_add_annotation(plot,lbid,amres)


  x          = ispan(1,32,1)

  rgba      = span_color_rgba("matlab_jet",32)

; wks = gsn_open_wks("png","lb")                   ; send graphics to PNG file

  ;wks_type = "eps"
  wks   = gsn_open_wks ("eps","Variances_sorted")

  res                       = True                 ; plot mods desired         
  ;res@gsnMaximize           = True                 ; maximize plot in frame
  res@gsnDraw               = False                ; don't draw plot yet
  res@gsnFrame              = False                ; don't advance frame yet

  res@trYMinF               = 28.                   ; bring bars down to zero
  res@trYMaxF               = 100.                   ; bring bars down to zero
  
  res@trXMinF               = min(x) - 1          ; adds space on either end
  res@trXMaxF               = max(x) + 1          ; of the 1st and last bars
  
  res@gsnXYBarChart         = True                 ; turn on bar chart
  res@gsnXYBarChartBarWidth = 0.65                 ; change bar widths
  res@gsnXYBarChartColors   = rgba
  
  res@tmXBOn                = False                ; turn off X tickmarks and labels
  res@tmXTOn                = False                ; turn off X tickmarks and labels

  res@tmYLMode              = "Explicit"
  res@tmYLValues            = (/0.,10.,20.,30.,40.,50.,60.,70.,80.,90.,100./)
  res@tmYLLabels            = (/"0","10","20","30","40","50","60","70","80","90","100"/)

  res@tiYAxisString         = "Variance explained [%]"



  str_color = new(32,string)
  str_color(:) = "black"
  ;str_color(1) = "red"
  ;str_color(3) = "red"
  ;str_color(4) = "red"
  ;str_color(10) = "red"
  ;str_color(16) = "red"
  ;str_color(18) = "red"
  ;str_color(:) = "red"
  ;str_color(10) = "black"


  ;vpw=0.8
  ;vph=0.8
  res@vpWidthF          = 0.7
  res@vpHeightF         = 0.9

  res@tiMainFont = 21
  res@tiMainFontHeightF = 0.022
  res@tiYAxisFont    = 21
  res@tiYAxisFontHeightF = 0.022 
  res@tiXAxisFont    = 21
  res@tiXAxisFontHeightF = 0.022

  res@tmYLLabelFontHeightF = 0.02 
  res@tmXBLabelFontHeightF = 0.02 


  ;res                    = True          ; labelbar only resources
  ;res@lbAutoManage       = True          ; Necessary to control sizes
  ;res@vpWidthF           = 0.2 * vpw     ; labelbar width
  ;res@vpHeightF          = 0.7 * vph     ; labelbar height
  ;res@lbBoxMajorExtentF  = 0.85          ; puts space between color boxes
  ;res@lbFillColors       = span_color_rgba("matlab_jet",29)          ; labelbar colors
  ;res@lbMonoFillPattern  = True          ; Solid fill pattern
  ;res@lbLabelFontHeightF = 0.08          ; font height. default is small
  ;res@lbLabelJust        = "CenterLeft"  ; left justify labels
  ;res@lbLabelAutoStride  = False

  ;printVarSummary(wks)

 res@gsnPanelBottom =0.1

  plot = gsn_csm_xy (wks,x(0:31),100.*var_exp(0:31),res)

  
;res@gsnPanelRight = 0.8

 ;printVarSummary(wks)


  ;getvalues plot                      ; Get plot size for use in
  ;  "vpHeightF" : vph                 ; creating labelbar.
  ;  "vpWidthF"  : vpw
  ;end getvalues

;draw(plot)   

;  print(vph)
;  print(vpw)
;
  lbres                    = True          ; labelbar only resources
  ;lbres@lbAutoManage       = True          ; Necessary to control sizes
  ;lbres@vpWidthF           = 0.2 ;* vpw     ; labelbar width
  ;lbres@vpHeightF          = 0.55 ;* vph     ; labelbar height
  lbres@lbBoxMajorExtentF  = 0.75          ; puts space between color boxes
  lbres@lbBoxMinorExtentF  = 0.05
  rgba=span_color_rgba("matlab_jet",32)          ; labelbar colors
  lbres@lbFillColors       = rgba(16:31:-1,:)        ; labelbar colors
  lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  lbres@lbLabelFontHeightF = 0.012          ; font height. default is small
  lbres@lbLabelJust        = "Centerleft"  ; left justify labels
  lbres@lbJustification   = "TopRight"
  lbres@lbLabelAutoStride  = False
  lbres@lbLabelOffsetF     =0.012

  lbres@lbLabelFontColor = str_color(16:31:-1)
  ;lbres@pmLabelBarWidthF         = 0.1       ; Decrease width
  ;lbres@pmLabelBarHeightF        = .5       ; Decrease height

  ;lbres@pmLabelBarOrthogonalPosF = -1.     ;  Move into plot
  ;lbres@pmLabelBarParallelPosF   = 0.     ; Move to right

  lbres@lbTopMarginF =-0.33
  lbres@lbBottomMarginF =0.5
  lbres@lbLeftMarginF=-0.3
  lbres@lbRightMarginF=0.45

 ;
 ;
 ;
  print("A")
 ;
 ;
 ;
 ;
 
  ;lbid = gsn_create_labelbar(wks,32,sort_corr_vec_str(0:31:-1),lbres)
  print("B")
 ; amres                  = True
 ; amres@amJust           = "TopRight"
 ; amres@amParallelPosF   =  0.4
 ; amres@amOrthogonalPosF = -0.5
 ; plot@annoid = gsn_add_annotation(plot,lbid,False)

gsn_labelbar_ndc(wks,16,var_str(16:31:-1),0.7,0.77,lbres)


  ;draw(plot)                                   ; Draws plot and labelbar
  ;frame(wks)

  rbres=lbres

  ;rbres@lbTopMarginF =-0.33
  ;rbres@lbBottomMarginF =0.13
  rbres@lbLeftMarginF=-0.65
  rbres@lbRightMarginF=0.8

  rbres@lbFillColors       = rgba(0:15:-1,:)        ; labelbar colors
  rbres@lbLabelFontColor = str_color(0:15:-1)

gsn_labelbar_ndc(wks,16,var_str(0:15:-1),0.7,0.77,rbres)


 resP=True

 resP@gsnPanelYWhiteSpacePercent = 1
 resP@gsnPanelXWhiteSpacePercent = 2

 resP@gsnPanelBottom = 0.1


  gsn_panel(wks,plot,(/1,1/),resP)    
 
end
