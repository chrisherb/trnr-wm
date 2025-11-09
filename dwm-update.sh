#!/bin/bash

# CPU Load (average over 1 minute)
cpu_load=$(awk '{printf "%s%%", $1}' /proc/loadavg)

# RAM Usage (free and used in GiB, 1 decimal)
read used total < <(free -m | awk '/^Mem:/ {print $3, $2}')
used_gb=$(awk "BEGIN {printf \"%.1f\", $used/1024}")
mem_info="${used_gb}gb"

## GPU Load (NVIDIA - needs nvidia-smi)
#if command -v nvidia-smi >/dev/null 2>&1; then
#gpu_load=$(nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits | \
#    awk -F', ' '{printf "%s%%", $1}')
#else
#gpu_load="n/a"
#fi

# Date and Time
datetime=$(date '+%d.%m. %H:%M')

if command -v amixer >/dev/null 2>&1; then
    volume=$(amixer get Master | awk -F'[][%]' '/%/ {print $2; exit}')
    mute=$(amixer get Master | grep -q '\[off\]' && echo "MUTE" || echo "")
    if [ "$mute" = "MUTE" ]; then
	volume="mute"
    else
	volume="${volume}%"
    fi
else
    volume="N/A"
fi

# Battery (single approach: sysfs /sys/class/power_supply)
get_bat_sysfs() {
    shopt -s nullglob
    bats=(/sys/class/power_supply/BAT*)
    shopt -u nullglob
    [ ${#bats[@]} -eq 0 ] && { echo "NoBatt"; return 0; }

    # For simplicity show info for the first battery; if you want combined, we can change it.
    bat="${bats[0]}"

    # Prefer 'capacity' if available (percentage), else compute from energy_/charge_ files
    if [ -f "$bat/capacity" ]; then
        percent="$(< "$bat/capacity")%"
    else
        # try energy_*, fallback to charge_*
        if [ -f "$bat/energy_now" ] && [ -f "$bat/energy_full" ]; then
            enow=$(< "$bat/energy_now")
            efull=$(< "$bat/energy_full")
            if [ "$efull" -gt 0 ]; then
                percent=$(awk "BEGIN{printf \"%d%%\", (${enow}*100)/${efull}}")
            else
                percent="n/a"
            fi
        elif [ -f "$bat/charge_now" ] && [ -f "$bat/charge_full" ]; then
            cnow=$(< "$bat/charge_now")
            cfull=$(< "$bat/charge_full")
            if [ "$cfull" -gt 0 ]; then
                percent=$(awk "BEGIN{printf \"%d%%\", (${cnow}*100)/${cfull}}")
            else
                percent="n/a"
            fi
        else
            percent="n/a"
        fi
    fi

    echo "${percent}"
}

battery_info=$(get_bat_sysfs)

# Combine all info
status=" cpu $cpu_load  ram $mem_info  bat $battery_info  vol $volume  $datetime "

xsetroot -name "$status"
