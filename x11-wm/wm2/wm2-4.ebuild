# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wm2/wm2-4.ebuild,v 1.2 2004/04/25 17:20:29 usata Exp $

inherit eutils

IUSE=""

DESCRIPTION="Small, unconfigurable window manager"
HOMEPAGE="http://www.all-day-breakfast.com/wm2/"
SRC_URI="http://www.all-day-breakfast.com/wm2/${P}.tar.gz"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}

	cd ${S}
	EPATCH_OPTS="-R"
	epatch ${FILESDIR}/${PF}-gentoo.patch

	sed 's/^#//' Config.h > wm2.conf
	if [ -e "/etc/wm2.conf" ]; then
		echo "#undef _CONFIG_H_" >> Config.h
		awk '/^[^/]/{print "#" $0}' /etc/wm2.conf >> Config.h
	fi
}

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	exeinto /usr/bin
	doexe wm2
	insinto /etc
	doins wm2.conf
	dodoc README
}

pkg_postinst() {
	einfo
	einfo "wm2 is unconfigurable after you have installed. If you want to"
	einfo "change settings of wm2, please have a look at /etc/wm2.conf"
	einfo "and rewrite it, then emerge wm2 again (wm2 ebuild uses settings"
	einfo "from that file automatically). If you think wm2 lacks some important"
	einfo "features that you want to use (such as background pixmaps),"
	einfo "consider using wmx, written by the same author."
	einfo
}
