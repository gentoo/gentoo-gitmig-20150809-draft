# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.13-r5.ebuild,v 1.4 2003/04/12 10:23:45 cybersystem Exp $

IUSE="nls"

inherit commonbox flag-o-matic eutils

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on Blackbox -- has tabs."
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.bz2"
HOMEPAGE="http://fluxbox.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc "

mydoc="ChangeLog COPYING NEWS"
myconf="--enable-xinerama"
if pkg-config xft
then
	CXXFLAGS="${CXXFLAGS} -I/usr/include/freetype2"
fi
filter-flags -fno-exceptions
export WANT_AUTOMAKE_1_6=1
export WANT_AUTOCONF_2_5=1

src_unpack() {

	unpack ${A}
	cd ${S}
	# Enable Xft2 patch is appropriate
	if pkg-config xft
	then
		epatch ${FILESDIR}/${P}-Xft2.patch
	fi
	# Enable keybindings for root and window menus
	epatch ${FILESDIR}/${P}-menukey.patch
	# Fix misshaped fonts on fluxbox first start
	epatch ${FILESDIR}/${P}-aa2.patch
	# Fix for Openoffice crashing X server
	epatch ${FILESDIR}/${P}-openoffice.patch
	# Make sure NLS catalogs get installed
	epatch ${FILESDIR}/${P}-nls.patch

	# NLS is still names after blackbox. Remind me to talk to fluxgen about this.
	ssed -i "s:blackbox.cat:fluxbox.cat:" \
		${S}/src/main.cc
}

src_compile() {

	commonbox_src_compile

	cd data
	make \
		pkgdatadir=/usr/share/commonbox init
}


src_install() {

	commonbox_src_install
	cd data
	insinto /usr/share/commonbox
	doins init
	insinto /usr/share/commonbox/fluxbox
	doins keys
	rm -f ${D}/usr/bin/fluxbox-generate_menu
}
