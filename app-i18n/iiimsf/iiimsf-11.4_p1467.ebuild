# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimsf/iiimsf-11.4_p1467.ebuild,v 1.1 2004/09/13 19:57:25 usata Exp $

inherit iiimf eutils

DESCRIPTION="server program to provide Input Method facilities via IIIMP"

KEYWORDS="x86"
IUSE=""

DEPEND="dev-libs/libiiimp"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	sed -i -e 's,$(IM_LIBDIR)/iiimp,/usr/lib,g' Makefile* \
		|| die "sed Makefile.{am,in} failed."
	sed -i -e 's,/usr/lib/im/htt.conf,/etc/im/htt.conf,g' IMSvrCfg.cpp \
		|| die "sed IMSvrCfg.cpp failed."
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
