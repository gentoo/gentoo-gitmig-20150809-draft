# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

DESCRIPTION="The is the base for all cron ebuilds."

#adds ".keep" files so that dirs aren't auto-cleaned
keepdir() {
    dodir $*
    local x
    for x in $*
    do
	touch ${D}/${x}/.keep
    done
}

src_install () {

    dodir /usr/sbin
    doexe ${FILESDIR}/run-crons

    insinto /etc
    doins ${FILESDIR}/crontab

    diropts -m0750; keepdir /etc/cron.hourly
    diropts -m0750; keepdir /etc/cron.daily
    diropts -m0750; keepdir /etc/cron.weekly
    diropts -m0750; keepdir /etc/cron.montly

    diropts -m0770 -o root -g cron; keepdir /var/spool/cron
    diropts -m0770 -o root -g cron; keepdir /var/spool/cron/crontabs

    diropts -m0750; keepdir /var/spool/cron/lastrun

    dodoc ${FILESDIR}/README

}
