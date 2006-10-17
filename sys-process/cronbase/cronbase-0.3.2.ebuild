# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/cronbase/cronbase-0.3.2.ebuild,v 1.18 2006/10/17 10:42:00 uberlord Exp $

inherit eutils

DESCRIPTION="base for all cron ebuilds"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

pkg_setup() {
	enewgroup cron 16
	enewuser cron 16 -1 /var/spool/cron cron
}

src_install() {
	newsbin "${FILESDIR}"/run-crons-${PV} run-crons || die

	diropts -m0750; keepdir /etc/cron.hourly
	diropts -m0750; keepdir /etc/cron.daily
	diropts -m0750; keepdir /etc/cron.weekly
	diropts -m0750; keepdir /etc/cron.monthly

	diropts -m0750 -o root -g cron; keepdir /var/spool/cron

	diropts -m0750; keepdir /var/spool/cron/lastrun

	dodoc "${FILESDIR}"/README
}
