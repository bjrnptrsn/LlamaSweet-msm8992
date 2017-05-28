#!/system/bin/sh


# parameters
CPUS_ONLINE=6
CPUS_ONLINE_LAST=6
CPU0_MIN_FREQ=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq`
#FREQ_ONLINE_1=384000 ## always 2 cores, becouse "target_loads" is above 100 (at least 1 processor at 100% and others at XX)
FREQ_ONLINE_1=1
FREQ_ONLINE_2=460000
FREQ_ONLINE_3=787000
FREQ_ONLINE_4=960000
FREQ_ONLINE_5=1248000
FREQ_ONLINE_6=1440000
SLEEP_DEFINED_TYPE=0 #0=no extra sleep, 1=PLUS SLEEP (core on), -1=MINUS SLEEP (core off)
SLEEPED=0

#!/system/bin/sh
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu4/online
echo 1 > /sys/devices/system/cpu/cpu5/online


for PR in 0 1 2 3
do
        echo "20000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/timer_rate
        echo 0 > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/above_hispeed_delay
        echo "144000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/hispeed_freq
        echo "75 460000:69 600000:80 672000:76 787000:81 864000:81 960000:69 1248000:78" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/target_loads
        echo "50000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/min_sample_time
        echo "-1" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/timer_slack
        echo "100" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/go_hispeed_load
        echo "0" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/io_is_busy
        echo "20000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/max_freq_hysteresis
done

for PR in 4 5
do
        echo "20000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/timer_rate
        echo 0 > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/above_hispeed_delay
        echo "1824000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/hispeed_freq
        echo " 74 768000:73 864000:64 960000:80 1248000:61 1344000:69 1440000:64 1536000:74 1632000:69 1689600:67 1824000:72" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/target_loads
        echo "60000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/min_sample_time
        echo "-1" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/timer_slack
        echo "90" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/go_hispeed_load
        echo "0" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/io_is_busy
        echo "20000" > /sys/devices/system/cpu/cpu${PR}/cpufreq/interactive/max_freq_hysteresis
done

while true; do

  #============================================
  # get cpu0 freq
  CPU0_CUR_FREQ=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq`

  #============================================
  # hotplugging logic

## always 2 cores, becouse "target_loads" is above 100 (at least 1 processor at 100% and others at XX)
#  if [ $CPU0_CUR_FREQ = $FREQ_ONLINE_1 ];
#  then
#    if [ $CPUS_ONLINE -gt 1 ] && [ $SLEEP_DEFINED_TYPE = 0 ];
#    then
#      echo 0 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
#      CPUS_ONLINE=$(expr $CPUS_ONLINE - 1)
#      SLEEP_DEFINED_TYPE=-1
#    fi
#  fi

#  if [ $CPU0_CUR_FREQ -ge $FREQ_ONLINE_2 ] && [ $CPU0_CUR_FREQ -lt $FREQ_ONLINE_3 ];
  if [ $CPU0_CUR_FREQ -ge $FREQ_ONLINE_1 ] && [ $CPU0_CUR_FREQ -lt $FREQ_ONLINE_3 ];
  then
    if [ $CPUS_ONLINE -gt 2 ] && [ $SLEEP_DEFINED_TYPE = 0 ];
    then
      echo 0 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      CPUS_ONLINE=$(expr $CPUS_ONLINE - 1)
      SLEEP_DEFINED_TYPE=-1
    elif [ $CPUS_ONLINE -lt 2 ] && ( [ $SLEEP_DEFINED_TYPE = 0 ] || [ $SLEEP_DEFINED_TYPE = -1 ] );
    then
      CPUS_ONLINE=$(expr $CPUS_ONLINE + 1)
      echo 1 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      SLEEP_DEFINED_TYPE=1
    fi
  fi

  if [ $CPU0_CUR_FREQ -ge $FREQ_ONLINE_3 ] && [ $CPU0_CUR_FREQ -lt $FREQ_ONLINE_4 ];
  then
    if [ $CPUS_ONLINE -gt 3 ] && [ $SLEEP_DEFINED_TYPE = 0 ];
    then
      echo 0 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      CPUS_ONLINE=$(expr $CPUS_ONLINE - 1)
      SLEEP_DEFINED_TYPE=-1
    elif [ $CPUS_ONLINE -lt 3 ] && ( [ $SLEEP_DEFINED_TYPE = 0 ] || [ $SLEEP_DEFINED_TYPE = -1 ] );
    then
      CPUS_ONLINE=$(expr $CPUS_ONLINE + 1)
      echo 1 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      SLEEP_DEFINED_TYPE=1
    fi
  fi

  if [ $CPU0_CUR_FREQ -ge $FREQ_ONLINE_4 ] && [ $CPU0_CUR_FREQ -lt $FREQ_ONLINE_5 ];
  then
    if [ $CPUS_ONLINE -gt 4 ] && [ $SLEEP_DEFINED_TYPE = 0 ];
    then
      echo 0 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      CPUS_ONLINE=$(expr $CPUS_ONLINE - 1)
      SLEEP_DEFINED_TYPE=-1
    elif [ $CPUS_ONLINE -lt 4 ] && ( [ $SLEEP_DEFINED_TYPE = 0 ] || [ $SLEEP_DEFINED_TYPE = -1 ] );
    then
      CPUS_ONLINE=$(expr $CPUS_ONLINE + 1)
      echo 1 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      SLEEP_DEFINED_TYPE=1
    fi
  fi

  if [ $CPU0_CUR_FREQ -ge $FREQ_ONLINE_5 ] && [ $CPU0_CUR_FREQ -lt $FREQ_ONLINE_6 ];
  then
    if [ $CPUS_ONLINE -gt 5 ] && [ $SLEEP_DEFINED_TYPE = 0 ];
    then
      echo 0 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      CPUS_ONLINE=$(expr $CPUS_ONLINE - 1)
      SLEEP_DEFINED_TYPE=-1
    elif [ $CPUS_ONLINE -lt 5 ] && ( [ $SLEEP_DEFINED_TYPE = 0 ] || [ $SLEEP_DEFINED_TYPE = -1 ] );
    then
      CPUS_ONLINE=$(expr $CPUS_ONLINE + 1)
      echo 1 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      SLEEP_DEFINED_TYPE=1
    fi
  fi

  if [ $CPU0_CUR_FREQ -ge $FREQ_ONLINE_6 ];
  then
    if [ $CPUS_ONLINE -lt 6 ] && ( [ $SLEEP_DEFINED_TYPE = 0 ] || [ $SLEEP_DEFINED_TYPE = -1 ] );
    then
      CPUS_ONLINE=$(expr $CPUS_ONLINE + 1)
      echo 1 > /sys/devices/system/cpu/cpu$(expr $CPUS_ONLINE - 1)/online
      SLEEP_DEFINED_TYPE=1
    fi
  fi

  #============================================
  # debug [show cpu core state changes]
  if [ $CPUS_ONLINE_LAST != $CPUS_ONLINE ];
  then
    echo $CPU0_CUR_FREQ, should_cores: $CPUS_ONLINE
    CPUS_ONLINE_LAST=$CPUS_ONLINE
  fi 

  #============================================
  # Set sleeping time
  if [ $CPUS_ONLINE -le 4 ];
  then
    SLEEP_PLUS=100000
  else #=5
    SLEEP_PLUS=300000
  fi #6 is max, so no plus sleep

  if [ $CPUS_ONLINE = 6 ];
  then
    SLEEP_MINUS=600000
  else
    SLEEP_MINUS=300000
  fi

  #============================================
  # Wait before checking again.
  usleep 100000

  #============================================
  # disable sleep if waited long enought
  if [ $SLEEP_DEFINED_TYPE = 0 ];
  then
    continue
#    SLEEPED=0
  else
    SLEEPED=$(expr $SLEEPED + 100000)
  fi
  
  if ( [ $SLEEP_DEFINED_TYPE = -1 ] || [ $SLEEP_DEFINED_TYPE = 1 ] ) && [ $SLEEPED -ge $SLEEP_MINUS ];
  then
    SLEEPED=0
    SLEEP_DEFINED_TYPE=0
  fi

done