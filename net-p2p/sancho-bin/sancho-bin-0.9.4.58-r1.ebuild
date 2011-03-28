# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/sancho-bin/sancho-bin-0.9.4.58-r1.ebuild,v 1.6 2011/03/28 14:30:52 nirbheek Exp $

EAPI="1"

inherit eutils

MY_P=${P/-bin/}
MY_P=${MY_P%.*}-${MY_P##*.}

DESCRIPTION="a powerful frontend for mldonkey"
HOMEPAGE="http://sancho-gui.sourceforge.net/"
SRC_URI="
	amd64? ( java? ( mirror://gentoo/${MY_P}-linux-gtk-x86_64-java.sh )
		!java? ( mirror://gentoo/${MY_P}-linux-gtk.sh ) )
	x86? ( java? ( mirror://gentoo/${MY_P}-linux-gtk-java.sh )
		!java? ( mirror://gentoo/${MY_P}-linux-gtk.sh ) )
	ppc? ( java? ( mirror://gentoo/${MY_P}-linux-gtk-ppc-java.sh ) )
"

RESTRICT="strip"

# In order to keyword ~ppc, 'java' should be package.use.force'd
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="CPL-1.0 LGPL-2.1"
IUSE="java"

DEPEND="x11-libs/libXxf86vm
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/gtk+:2
	amd64? ( !java? ( >=app-emulation/emul-linux-x86-baselibs-1.0
			>=app-emulation/emul-linux-x86-gtklibs-1.0 ) )
	java? ( >=virtual/jre-1.5 )"

S="${WORKDIR}"

src_unpack() {
	unpack_makeself
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

	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/50-${PN}

	make_desktop_entry sancho sancho /opt/sancho/distrib/sancho-32.xpm
}

pkg_postinst() {
	elog
	elog "Sancho requires the presence of a p2p core, like"
	elog "net-p2p/mldonkey, in order to operate. This core"
	elog "may be in other machine of your network."
	elog
}
