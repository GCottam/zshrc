uname -p
lscpu | grep "Model name"
grep 'cpuMHz' /proc/cpuinfo
cpu_temp=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))

echo "cpu temperature : ${cpu_temp}°C"
