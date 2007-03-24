# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/sancho-bin/sancho-bin-0.9.4.58.ebuild,v 1.4 2007/03/24 14:25:10 armin76 Exp $

inherit eutils

MY_P=${P/-bin/}
MY_P=${MY_P%.*}-${MY_P##*.}

DESCRIPTION="a powerful frontend for mldonkey"
HOMEPAGE="http://sancho-gui.sourceforge.net/"
SRC_URI="mirror://gentoo/${MY_P}-linux-gtk.sh"
RESTRICT="strip"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="CPL-1.0 LGPL-2.1"
IUSE=""

DEPEND="virtual/libc
	|| ( ( x11-libs/libXxf86vm
		x11-libs/libXext
		x11-libs/libX11
	    ) virtual/x11 )
	>=x11-libs/gtk+-2
	>=net-libs/linc-1.0.3
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-1.0
			>=app-emulation/emul-linux-x86-gtklibs-1.0 )"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/sancho-0.9.4-58-linux-gtk.sh" .
	epatch "${FILESDIR}/${P}-ignore-homedir-check.patch"
	sh sancho-0.9.4-58-linux-gtk.sh --target .
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /opt/sancho
	dodir /opt/bin

	cd "${S}"
	cp -dpR sancho distrib lib ${D}/opt/sancho

	exeinto /opt/sancho
	newexe sancho sancho-bin

	exeinto /opt/bin
	newexe ${FILESDIR}/sancho.sh sancho

	dodir /etc/env.d
	echo -e "PATH=/opt/sancho\n" > ${D}/etc/env.d/20sancho

	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/50-${PN}

	make_desktop_entry sancho sancho /opt/sancho/distrib/sancho-32.xpm
}

pkg_postinst() {
	einfo
	einfo "Sancho requires the presence of a p2p core, like"
	einfo "net-p2p/mldonkey, in order to operate."
	einfo
}
