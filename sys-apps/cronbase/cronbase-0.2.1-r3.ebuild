# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cronbase/cronbase-0.2.1-r3.ebuild,v 1.12 2004/04/24 08:42:39 vapier Exp $

DESCRIPTION="base for all cron ebuilds"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc mips alpha arm hppa amd64 ~ia64 s390"

src_install() {
	exeinto /usr/sbin
	doexe ${FILESDIR}/run-crons || die

	diropts -m0750; keepdir /etc/cron.hourly
	diropts -m0750; keepdir /etc/cron.daily
	diropts -m0750; keepdir /etc/cron.weekly
	diropts -m0750; keepdir /etc/cron.monthly

	diropts -m0750 -o root -g cron; keepdir /var/spool/cron

	diropts -m0750; keepdir /var/spool/cron/lastrun

	dodoc ${FILESDIR}/README
}
