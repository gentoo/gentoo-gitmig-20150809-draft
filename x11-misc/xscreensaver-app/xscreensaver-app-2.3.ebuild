# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver-app/xscreensaver-app-2.3.ebuild,v 1.2 2004/04/11 17:44:48 pyrania Exp $

IUSE=""

MY_PN=${PN/-a/.A}
MY_PN=${MY_PN/xs/XS}
MY_PN=${MY_PN/s/S}
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="XScreenSaver dockapp for the Window Maker window manager."
SRC_URI=" http://www.asleep.net/download/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://www.asleep.net/hacking/XScreenSaver.App/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	x11-libs/libdockapp"

RDEPEND="x11-misc/xscreensaver"

src_compile() {
	econf || die "Configuration failed"
	emake || die "Make Failed"
}

src_install () {
	einstall || die "Install failed"
	dodoc README INSTALL COPYING NEWS ChangeLog TODO AUTHORS
}
