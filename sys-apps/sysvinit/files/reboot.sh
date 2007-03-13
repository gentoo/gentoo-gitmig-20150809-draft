# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

opts="-dpk"
[ "${RC_DOWN_INTERFACE}" = "yes" ] && opts="${opts}i"

/sbin/reboot "${opts}" 2>/dev/null

# hmm, if the above failed, that's kind of odd ...
# unless it's busybox
/sbin/reboot -f
