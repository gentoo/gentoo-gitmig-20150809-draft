# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimsf/iiimsf-11.4.1467.ebuild,v 1.3 2004/03/10 20:24:59 usata Exp $

inherit iiimf

DESCRIPTION="IIIMSF is a server program to provide Input Method facilities via IIIMP"

KEYWORDS="~x86"
DEPEND="dev-libs/libiiimp"

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {

	exeinto /usr/lib/im
	doexe src/htt src/htt_server
	exeinto /etc/init.d
	newexe ${FILESDIR}/iiim.initd iiim
	insinto /etc/im
	doins ${FILESDIR}/htt.conf

	dodoc ChangeLog htt.conf
}
