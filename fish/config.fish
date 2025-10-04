if status is-interactive
    fastfetch
end

function fish_greeting
    set -l greetings \
        "Ну че, за работу, негры" \
        "Попробуй sudo rm -rf /,  поверь, это точно удалит все вирусы" \
        "Arch для задротов без личной жизни" \
        "Сайдаш лох, тут по фактам" \
        "davai eBash" \
        "sudo pacman -S brain"

    set -l index (random 1 (count $greetings))
    echo $greetings[$index]
end

alias vpn="adguardvpn-cli connect -l FI"

alias ls="lsd"
