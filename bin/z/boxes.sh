#!/bin/bash
#位置定义
app='/opt/QtPalmtop/bin/z'
data='/opt/QtPalmtop/data/z/boxes'
ctrlf='/opt/QtPalmtop/data/z/common/ctrl.dat'
tmpf='/tmp/Boxes_filelist.tmp'
ltmp='/tmp/ListSelect.tmp'
save='/Settings/Boxes.conf'

#变量定义
for ((n=0;n<16;n++)); do
  declare -a line$n
done
inc='\E[93;40m'
namec='\E[92;40m'; levelc='\E[94;40m'
light='\E[97;40m'; end='\E[0m'
declare -a block=("'\E[95;40m  ' '\E[95;107m  ' \
'\E[95;102m×' '\E[95;101m⊙' '\E[95;104mΩ' \
'\E[95;103m∩' '\E[95;106mΔ'") record \
ctrl=("$(<$ctrlf)") player \
comc=("'\E[31m' '\E[91;102m'")

#函数
prog_level(){
  levelnum=0; test=0
  echo -ne "$inc创建关卡列表中...$end"
  if [ -e level0.map ]; then test=1; fi
  ls -1 *.map > $tmpf
  while read line; do
    ((levelnum++))
  done < $tmpf
  levelnum=$((levelnum-test))
  $app/List.sh "       推箱子" "       Made By Norman (ZHIYB)"\
  "" "1" "10" "$level"\
  "$([ $test = 1 ] && echo -n "' TestMap ' "
    for ((n=1;n<=levelnum;n++)); do echo -n "' Level $n ' "; done)\
  '$comc 退    出 '"
  stty -echo; echo -en "\E[?25l"
  case $(<$ltmp) in
  $((levelnum+test)) ) prog_quit;;
  * ) level=$(($(<$ltmp)+1-test));;
  esac
  prog_msg
}
prog_msg(){
  win=0; step=0; bak=1; minstep=0; unset record[@] declare1
  echo -en "${light}Level $level $inc读取中...$end"
  for ((n=0;n<16;n++)); do
    unset line$n[@]; read -a line$n
    tmp="line$n[@]"; tmp2="${!tmp}"
    until [ $(expr index "$tmp2" 3) = 0 ]; do
      ((win++)); tmp2=${tmp2#*3}
    done
    [ $(expr index "${!tmp}" 5) != 0 ] && player=($n $(($(expr index "${!tmp}" 5)/2)))
  done < "$data/level${level}.map"
  [ -e "$data/level${level}.sav" ] && minstep=$(<"$data/level${level}.sav")
  echo -n $level > $save
}
prog_show(){
  echo -en "\E[2J\E[1;1H${block[line0[0]]}${block[line0[1]]}${block[line0[2]]}${block[line0[3]]}${block[line0[4]]}${block[line0[5]]}${block[line0[6]]}${block[line0[7]]}${block[line0[8]]}${block[line0[9]]}${block[line0[10]]}${block[line0[11]]}${block[line0[12]]}${block[line0[13]]}${block[line0[14]]}${block[line0[15]]}$light  |$end
${block[line1[0]]}${block[line1[1]]}${block[line1[2]]}${block[line1[3]]}${block[line1[4]]}${block[line1[5]]}${block[line1[6]]}${block[line1[7]]}${block[line1[8]]}${block[line1[9]]}${block[line1[10]]}${block[line1[11]]}${block[line1[12]]}${block[line1[13]]}${block[line1[14]]}${block[line1[15]]}$light  |$namec  ***推箱子***$end
${block[line2[0]]}${block[line2[1]]}${block[line2[2]]}${block[line2[3]]}${block[line2[4]]}${block[line2[5]]}${block[line2[6]]}${block[line2[7]]}${block[line2[8]]}${block[line2[9]]}${block[line2[10]]}${block[line2[11]]}${block[line2[12]]}${block[line2[13]]}${block[line2[14]]}${block[line2[15]]}$light  |$levelc    Level $light$level$end
${block[line3[0]]}${block[line3[1]]}${block[line3[2]]}${block[line3[3]]}${block[line3[4]]}${block[line3[5]]}${block[line3[6]]}${block[line3[7]]}${block[line3[8]]}${block[line3[9]]}${block[line3[10]]}${block[line3[11]]}${block[line3[12]]}${block[line3[13]]}${block[line3[14]]}${block[line3[15]]}$light  |$end
${block[line4[0]]}${block[line4[1]]}${block[line4[2]]}${block[line4[3]]}${block[line4[4]]}${block[line4[5]]}${block[line4[6]]}${block[line4[7]]}${block[line4[8]]}${block[line4[9]]}${block[line4[10]]}${block[line4[11]]}${block[line4[12]]}${block[line4[13]]}${block[line4[14]]}${block[line4[15]]}$light  |    ${comc[((dat==0))]} 撤  消 $end
${block[line5[0]]}${block[line5[1]]}${block[line5[2]]}${block[line5[3]]}${block[line5[4]]}${block[line5[5]]}${block[line5[6]]}${block[line5[7]]}${block[line5[8]]}${block[line5[9]]}${block[line5[10]]}${block[line5[11]]}${block[line5[12]]}${block[line5[13]]}${block[line5[14]]}${block[line5[15]]}$light  |$end
${block[line6[0]]}${block[line6[1]]}${block[line6[2]]}${block[line6[3]]}${block[line6[4]]}${block[line6[5]]}${block[line6[6]]}${block[line6[7]]}${block[line6[8]]}${block[line6[9]]}${block[line6[10]]}${block[line6[11]]}${block[line6[12]]}${block[line6[13]]}${block[line6[14]]}${block[line6[15]]}$light  |    ${comc[((dat==1))]} 重  玩 $end
${block[line7[0]]}${block[line7[1]]}${block[line7[2]]}${block[line7[3]]}${block[line7[4]]}${block[line7[5]]}${block[line7[6]]}${block[line7[7]]}${block[line7[8]]}${block[line7[9]]}${block[line7[10]]}${block[line7[11]]}${block[line7[12]]}${block[line7[13]]}${block[line7[14]]}${block[line7[15]]}$light  |$end
${block[line8[0]]}${block[line8[1]]}${block[line8[2]]}${block[line8[3]]}${block[line8[4]]}${block[line8[5]]}${block[line8[6]]}${block[line8[7]]}${block[line8[8]]}${block[line8[9]]}${block[line8[10]]}${block[line8[11]]}${block[line8[12]]}${block[line8[13]]}${block[line8[14]]}${block[line8[15]]}$light  |    ${comc[((dat==2))]} 返  回 $end
${block[line9[0]]}${block[line9[1]]}${block[line9[2]]}${block[line9[3]]}${block[line9[4]]}${block[line9[5]]}${block[line9[6]]}${block[line9[7]]}${block[line9[8]]}${block[line9[9]]}${block[line9[10]]}${block[line9[11]]}${block[line9[12]]}${block[line9[13]]}${block[line9[14]]}${block[line9[15]]}$light  |$end
${block[line10[0]]}${block[line10[1]]}${block[line10[2]]}${block[line10[3]]}${block[line10[4]]}${block[line10[5]]}${block[line10[6]]}${block[line10[7]]}${block[line10[8]]}${block[line10[9]]}${block[line10[10]]}${block[line10[11]]}${block[line10[12]]}${block[line10[13]]}${block[line10[14]]}${block[line10[15]]}$light  |$inc  已走$light$step$inc步$end
${block[line11[0]]}${block[line11[1]]}${block[line11[2]]}${block[line11[3]]}${block[line11[4]]}${block[line11[5]]}${block[line11[6]]}${block[line11[7]]}${block[line11[8]]}${block[line11[9]]}${block[line11[10]]}${block[line11[11]]}${block[line11[12]]}${block[line11[13]]}${block[line11[14]]}${block[line11[15]]}$light  |$end
${block[line12[0]]}${block[line12[1]]}${block[line12[2]]}${block[line12[3]]}${block[line12[4]]}${block[line12[5]]}${block[line12[6]]}${block[line12[7]]}${block[line12[8]]}${block[line12[9]]}${block[line12[10]]}${block[line12[11]]}${block[line12[12]]}${block[line12[13]]}${block[line12[14]]}${block[line12[15]]}$light  |$inc  最少$light$((minstep==0?step:minstep))$inc步$end
${block[line13[0]]}${block[line13[1]]}${block[line13[2]]}${block[line13[3]]}${block[line13[4]]}${block[line13[5]]}${block[line13[6]]}${block[line13[7]]}${block[line13[8]]}${block[line13[9]]}${block[line13[10]]}${block[line13[11]]}${block[line13[12]]}${block[line13[13]]}${block[line13[14]]}${block[line13[15]]}$light  |$end
${block[line14[0]]}${block[line14[1]]}${block[line14[2]]}${block[line14[3]]}${block[line14[4]]}${block[line14[5]]}${block[line14[6]]}${block[line14[7]]}${block[line14[8]]}${block[line14[9]]}${block[line14[10]]}${block[line14[11]]}${block[line14[12]]}${block[line14[13]]}${block[line14[14]]}${block[line14[15]]}$light  |$inc  剩余$light$win$inc个箱子$end
${block[line15[0]]}${block[line15[1]]}${block[line15[2]]}${block[line15[3]]}${block[line15[4]]}${block[line15[5]]}${block[line15[6]]}${block[line15[7]]}${block[line15[8]]}${block[line15[9]]}${block[line15[10]]}${block[line15[11]]}${block[line15[12]]}${block[line15[13]]}${block[line15[14]]}${block[line15[15]]}$light  |$end"
}
prog_check(){
  next_block=1; next_block2=${!tmp2}
  case ${!tmp} in
  0 | 2 ) return 1;;
  1 | 4 ) bak2=${!tmp};;
  3 | 6)
    case ${!tmp2} in
    1 ) next_block2=3; bak2=$((${!tmp}==3?1:4))
      win=$((win+((${!tmp}==6))));;
    4 ) next_block2=6; bak2=$((${!tmp}==3?1:4))
      win=$((win-((${!tmp}==3))));;
    * ) return 1;;
    esac;;
  esac
  record[${#record[@]}]=$key
  record[${#record[@]}]=$((${!tmp}==3?1:((${!tmp}==6))))
  init=$bak; bak=$bak2; ((step++))
  next_block=5; return 0
}
prog_win(){
  [ $win = 0 ] || return $win
  ((step<((minstep==0?step+1:minstep)))) && minstep=$step && echo -n $step > "$data/level${level}.sav"
  $app/MsgBox.sh "4 14 0 0" "Congratulations! '过关!  $step步'"\
  "下一关 重玩此关 查看关卡地图 返回主菜单"
  tmp=$?
  stty -echo; echo -en "\E[?25l"; winq=0
  case $tmp in
  0 )
    if [ $levelnum = $level ]; then prog_finish
    else ((level++)); prog_msg
    fi;;
  1 ) prog_msg;;
  2 ) prog_show; read -s;;
  3 ) prog_level;;
  esac
  return $winq
}
prog_finish(){
  $app/Msgbox.sh "4 14 0 0" "Congratulations! 这是最后一关!"\
  "重新开始 重玩此关 查看关卡地图 返回主菜单"
  tmp=$?
  stty -echo; echo -en "\E[?25l"
  case $tmp in
  0 ) level=0; prog_msg;;
  1 ) prog_msg;;
  2 ) prog_show; read -s;;
  3 ) prog_level;;
  esac
}
prog_select(){
  dat=0; unset declare1
  until [ $dat = 3 ]; do
    prog_show
    read -sn 3 key
    case "$key" in
    "${ctrl[0]}" ) ((dat=dat==0?0:dat-1));;
    "${ctrl[1]}" ) ((dat=dat==2?2:dat+1));;
    "${ctrl[2]}" ) dat=0;;
    "${ctrl[3]}" ) dat=2;;
    "${ctrl[4]:0:3}" ) read -sn 2; dat=3;;
    "" )
      case $dat in
      0 ) prog_return;;
      1 ) prog_msg;;
      2 ) prog_level;;
      esac
      dat=3;;
    esac
  done
}
prog_return(){
  [ ${#record[@]} = 0 ] && echo -en "$inc无可撤消操作!$end" && usleep 500000 && return 1
  do_box=${record[${#record[@]}-1]}; unset record[${#record[@]}-1]
  key=${record[${#record[@]}-1]}; unset record[${#record[@]}-1]
  tmp1="line${player[0]}[${player[1]}]"
  case $key in
  0 ) tmp="line$((player[0]+1))[${player[1]}]"
    tmp2="line$((player[0]-1))[${player[1]}]"
    player[0]=$((player[0]+1));;
  1 ) tmp="line$((player[0]-1))[${player[1]}]"
    tmp2="line$((player[0]+1))[${player[1]}]"
    player[0]=$((player[0]-1));;
  2 ) tmp="line${player[0]}[$((player[1]+1))]"
    tmp2="line${player[0]}[$((player[1]-1))]"
    player[1]=$((player[1]+1));;
  3 ) tmp="line${player[0]}[$((player[1]-1))]"
    tmp2="line${player[0]}[$((player[1]+1))]"
    player[1]=$((player[1]-1));;
  esac
  [ $do_box = 0 ] && {
    declare1="$tmp=5 $tmp1=$bak"
    ((step--)); bak=${!tmp}; return 0
  }
  declare1="$tmp=5 $tmp1=$((bak==4?6:3)) $tmp2=$((${!tmp2}==6?4:1))"
  win=$((win-((bak==4?((${!tmp2}==6?0:1)):((${!tmp2}==6?(-1):0))))))
  ((step--)); bak=${!tmp}
}
prog_quit(){
  echo -e "$inc退出...$end"
  killall embeddedkonsole
  exit
}

#初始化
stty -echo; echo -en "\E[?25l"
cd $data; quit=0; bak=1; level=0; dat=3
[ -e $save ] && level=$(<$save)

#主程序
prog_level
until [ $quit = 1 ]; do
  prog_show
  prog_win && continue
  read -sn 3 key
  case "$key" in
  "${ctrl[0]}" )
    [ ${player[0]} = 0 ] && continue; key=0
    tmp="line$((player[0]-1))[${player[1]}]"
    tmp2="line$((player[0]-2))[${player[1]}]"
    [ ${player[0]} = 1 ] && tmp2=tmp3
    prog_check || continue
    declare -a line${player[0]}[${player[1]}]=$init $tmp=$next_block $tmp2=$next_block2
    player[0]=$((next_block==5?player[0]-1:player[0]));;
  "${ctrl[1]}" )
    [ ${player[0]} = 15 ] && continue; key=1
    tmp="line$((player[0]+1))[${player[1]}]"
    tmp2="line$((player[0]+2))[${player[1]}]"
    prog_check || continue
    declare -a line${player[0]}[${player[1]}]=$init $tmp=$next_block $tmp2=$next_block2
    player[0]=$((next_block==5?player[0]+1:player[0]));;
  "${ctrl[2]}" )
    [ ${player[1]} = 0 ] && continue; key=2
    tmp="line${player[0]}[$((player[1]-1))]"
    tmp2="line${player[0]}[$((player[1]-2))]"
    [ ${player[1]} = 1 ] && tmp2=tmp3
    prog_check || continue
    declare -a line${player[0]}[${player[1]}]=$init $tmp=$next_block $tmp2=$next_block2
    player[1]=$((next_block==5?player[1]-1:player[1]));;
  "${ctrl[3]}" )
    [ ${player[1]} = 15 ] && continue; key=3
    tmp="line${player[0]}[$((player[1]+1))]"
    tmp2="line${player[0]}[$((player[1]+2))]"
    prog_check || continue
    declare -a line${player[0]}[${player[1]}]=$init $tmp=$next_block $tmp2=$next_block2
    player[1]=$((next_block==5?player[1]+1:player[1]));;
  ${ctrl[4]:0:3} ) read -sn 2; prog_select
    declare -a a $declare1
  esac
done
stty -echo; echo -e "\E[?25h"; exit 0
