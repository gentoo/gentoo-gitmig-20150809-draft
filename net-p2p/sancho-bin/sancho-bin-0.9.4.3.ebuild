# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/sancho-bin/sancho-bin-0.9.4.3.ebuild,v 1.2 2004/05/01 06:02:12 squinky86 Exp $

IUSE="gtk2"

DESCRIPTION="a powerful frontend for mldonkey"
SRC_URI="gtk2? ( http://sancho-gui.sourceforge.net/tmp/${PN/-bin/}-${PV/.3/-3}-linux-gtk.tar.bz2 )
	!gtk2? ( http://sancho-gui.sourceforge.net/tmp/${PN/-bin/}-${PV/.3/-3}-linux-fox.tar.bz2 )"
HOMEPAGE="http://sancho-gui.sourceforge.net/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="CPL-1.0 LGPL-2.1"
RESTRICT="nomirror"

DEPEND="virtual/glibc
	virtual/x11
	gtk2? ( >=x11-libs/gtk+-2 )"

use gtk2 && TOOLKIT="gtk" || TOOLKIT="fox"
S="${WORKDIR}/${PN/-bin/}-${PV/.3/-3}-linux-${TOOLKIT}"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /opt/sancho
	dodir /opt/bin

	cd ${S}
	cp -dpR sancho distrib lib ${D}/opt/sancho

	exeinto /opt/sancho
	doexe sancho-bin

	exeinto /opt/bin
	newexe ${FILESDIR}/sancho.sh sancho

	dodir /etc/env.d
	echo -e "PATH=/opt/sancho\n" > ${D}/etc/env.d/20sancho
}

pkg_postinst() {
	einfo
	einfo "Sancho requires the presence of a p2p core, like"
	einfo "net-p2p/mldonkey, in order to operate."
	einfo
}
