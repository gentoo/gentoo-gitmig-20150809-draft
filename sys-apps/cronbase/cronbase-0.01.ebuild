# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cronbase/cronbase-0.01.ebuild,v 1.5 2002/05/13 18:34:05 bangert Exp $

DESCRIPTION="The is the base for all cron ebuilds."
HOMEPAGE="http://www.gentoo.org/"
LICENSE="GPL-2"

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

	exeinto /usr/sbin
	doexe ${FILESDIR}/run-crons

	diropts -m0750; keepdir /etc/cron.hourly
	diropts -m0750; keepdir /etc/cron.daily
	diropts -m0750; keepdir /etc/cron.weekly
	diropts -m0750; keepdir /etc/cron.monthly

	diropts -m0750 -o root -g cron; keepdir /var/spool/cron

	diropts -m0750; keepdir /var/spool/cron/lastrun

	dodoc ${FILESDIR}/README

}
