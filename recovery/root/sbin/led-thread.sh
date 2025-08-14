#!/sbin/sh

LED_PATH="/sys/bus/i2c/devices/0-003f/frame"
BOOT_ANIM_PATH="/sys/bus/i2c/devices/0-003f/boot_animation"

echo 0 > "$BOOT_ANIM_PATH" 2>/dev/null || true

TWRP_BLUE="0080ff"
PURPLE="8866ff"
RED="ff0000"
GREEN="00ff00"
BLACK="000000"

initial_animation() {
    round=1
    while [ $round -le 3 ]; do
        led=0
        while [ $led -le 11 ]; do
            frame=""
            pos=0
            while [ $pos -le 11 ]; do
                if [ $pos -eq $led ]; then
                    frame="${frame}${TWRP_BLUE}"
                elif [ $pos -eq $(( (led + 6) % 12 )) ]; then
                    frame="${frame}${TWRP_BLUE}"
                else
                    frame="${frame}${BLACK}"
                fi
                pos=$((pos + 1))
            done
            echo "$frame" > "$LED_PATH"
            sleep 0.08
            led=$((led + 1))
        done
        round=$((round + 1))
    done
    
    fill_ring "$TWRP_BLUE"
    sleep 0.3
}

get_animation() {
    getprop leds.animation 2>/dev/null || echo "default"
}

clear_ring() {
    echo "000000000000000000000000000000000000000000000000000000000000000000000000" > "$LED_PATH"
}

fill_ring() {
    color="$1"
    frame="${color}${color}${color}${color}${color}${color}${color}${color}${color}${color}${color}${color}"
    echo "$frame" > "$LED_PATH"
}

alternating_pulse() {
    color="$1"
    frame=""
    led=0
    while [ $led -le 11 ]; do
        if [ $(( led % 2 )) -eq 0 ]; then
            frame="${frame}${color}"
        else
            frame="${frame}${BLACK}"
        fi
        led=$((led + 1))
    done
    echo "$frame" > "$LED_PATH"
    sleep 0.6
    
    frame=""
    led=0
    while [ $led -le 11 ]; do
        if [ $(( led % 2 )) -eq 1 ]; then
            frame="${frame}${color}"
        else
            frame="${frame}${BLACK}"
        fi
        led=$((led + 1))
    done
    echo "$frame" > "$LED_PATH"
    sleep 0.6
}

blink_animation() {
    color="$1"
    duration="$2"
    start_time=$(date +%s)
    
    while true; do
        current_time=$(date +%s)
        if [ $((current_time - start_time)) -ge "$duration" ]; then
            break
        fi
        
        fill_ring "$color"
        sleep 0.3
        clear_ring
        sleep 0.3
    done
}

error_animation() {
    blink_animation "$RED" 5
    setprop leds.animation "default"
}

success_animation() {
    blink_animation "$GREEN" 5
    setprop leds.animation "default"
}

sideload_animation() {
    alternating_pulse "$PURPLE"
}

default_animation() {
    alternating_pulse "$TWRP_BLUE"
}

animation_loop() {
    current_animation=""
    
    while true; do
        animation=$(get_animation)
        
        if [ "$animation" != "$current_animation" ]; then
            current_animation="$animation"
            
            case "$animation" in
                "error")
                    error_animation
                    ;;
                "success")
                    success_animation
                    ;;
                "sideload")
                    sideload_animation
                    ;;
                *)
                    default_animation
                    ;;
            esac
        else
            case "$animation" in
                "sideload")
                    sideload_animation
                    ;;
                "default"|*)
                    default_animation
                    ;;
            esac
        fi
    done
}

main() {
    clear_ring
    initial_animation
    animation_loop
}

main &