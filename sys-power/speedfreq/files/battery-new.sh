#!/bin/sh
# Battery acpi script that set different speedfreq modes depending on AC adapter
# Can only handle one battery at the time, will add support for more when I get time
#
# To use this script add the following lines to /etc/acpi/events/default
#  event=battery.*
#  action=/etc/acpi/battery.sh %e

set $*
source /etc/conf.d/speedfreq
[ "${SPEEDFREQ_SPEED}" != "auto" ] && exit 0

case "$2" in
	BAT0)
		if [ $4 -eq 00000001 ] && [ -f /proc/acpi/battery/BAT0/state ] ; then
			action="`cat /proc/acpi/battery/BAT0/state | grep charging | cut -c 26-`"
			case $action in
				charging)       /usr/bin/speedfreq -p performance
						logger "A/C adapter plugged in"
						;;
				discharging)    /usr/bin/speedfreq -p powersave
						logger "A/C adapter plugged out"
						;;
			esac
		fi
		;;

	BAT1)
		if [ $4 -eq 00000001 ] && [ -f /proc/acpi/battery/BAT1/state ] ; then
			action="`cat /proc/acpi/battery/BAT1/state | grep charging | cut -c 26-`"
			case $action in
				charging)	/usr/bin/speedfreq -p performance
						logger "A/C adapter plugged in"
						;;
				discharging)	/usr/bin/speedfreq -p powersave
						logger "A/C adapter plugged out"
						;;
			esac
		fi
		;;
esac
