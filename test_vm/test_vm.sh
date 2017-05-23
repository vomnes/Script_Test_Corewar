#!/bin/sh

corewar_cor1_cor2()
{
    declare -i count=0
    echo "\033[1;33m$1 vs $2 :\033[0m\c "
    ~/Documents/rendu_corewar/asm $1.s > /dev/null 2>&1
    ~/Documents/rendu_corewar/asm $2.s > /dev/null 2>&1
    echo " [2] \c"
    ./cor_zaz/corewar -v 31 $1.cor $2.cor > output2
    echo "[1]\c"
    total=$(ls -la | grep "output2" | awk '{print $5}')
    ~/Documents/rendu_corewar/corewar -v 31 $1.cor $2.cor > output1 & pid=$!
    trap "kill $pid 2> /dev/null" EXIT
    echo ""
    while kill -0 $pid 2> /dev/null; do
        current_size=$(ls -la | grep "output1" | awk '{print $5}')
        update=$(echo "scale=2;100 * $current_size / $total" | bc)
        printf "\rLoading [%.f%%]" $update
    done
    printf "\rLoading [100%%] >>"
    trap - EXIT
    diff output1 output2 > output_diff
    if [[ -s output_diff ]]
    then echo "\033[0;31m FAILURE\033[0m"
    diff output1 output2
    else echo "\033[0;32m SUCCESS\033[0m"
    rm output1
    rm output2
    rm output_diff
    fi
}

rm -r diff
mkdir diff
make -C ../../VM_/

# Check all players in a folder
#for it in $@
#do
#    name=sed 's/].*//' $it
#    corewar_cor1_cor2 players/_ $name
#done

corewar_cor1_cor2 ../../champs/jumper ../../VM_/amric_player
corewar_cor1_cor2 ../../champs/jumper ../../VM_/l
corewar_cor1_cor2 ../../VM_/amric_player ../../VM_/l
corewar_cor1_cor2 ../../VM_/l ../../champs/jumper
# # corewar_cor1_cor2 ../../champs/Car ../../VM_/l
corewar_cor1_cor2 ../../champs/mortel ../../VM_/l
corewar_cor1_cor2 ../../champs/toto ../../VM_/l
corewar_cor1_cor2 ../../VM_/l ../../champs/toto
# # corewar_cor1_cor2 ../../champs/car ../../champs/gagnant
# # corewar_cor1_cor2 ../../champs/jumper ../../champs/car
corewar_cor1_cor2 ../../champs/jumper ../../champs/ex
corewar_cor1_cor2 ../../champs/Octobre_Rouge_V4.2 ../../VM_/a
corewar_cor1_cor2 ../../champs/Octobre_Rouge_V4.2 ../../champs/jumper
corewar_cor1_cor2 ../../champs/slider2 ../../champs/maxidef
corewar_cor1_cor2 ../../champs/mortel ../../champs/maxidef
corewar_cor1_cor2 ../../champs/toto ../../champs/slider2
corewar_cor1_cor2 ../../champs/Octobre_Rouge_V4.2 ../../champs/maxidef

#car gagnant -barriere jumper lde maxidef mat mortel slider2 toto"
