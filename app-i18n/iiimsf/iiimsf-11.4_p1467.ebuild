# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimsf/iiimsf-11.4_p1467.ebuild,v 1.3 2005/07/10 20:35:51 swegener Exp $

inherit iiimf eutils

DESCRIPTION="server program to provide Input Method facilities via IIIMP"

KEYWORDS="x86"
IUSE=""

RDEPEND="dev-libs/libiiimp"
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
