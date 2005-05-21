# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/idesk/idesk-0.5.6.ebuild,v 1.11 2005/05/21 09:11:29 blubb Exp $

DESCRIPTION="Utility to place icons on the root window"
HOMEPAGE="http://idesk.timmfin.net"
SRC_URI="mirror://sourceforge/idesk/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc x86 ~hppa"
IUSE=""

DEPEND=">media-libs/imlib-1.9.14
	virtual/x11
	media-libs/freetype
	>=gnome-base/librsvg-2.2.5
	>=dev-util/pkgconfig-0.12.0
	dev-libs/libxml2
	=dev-libs/glib-2*
	gnome-extra/libgsf
	=x11-libs/pango-1*
	=x11-libs/gtk+-2*
	media-libs/libart_lgpl"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}

	#Allow for more robust CXXFLAGS
	mv Makefile Makefile.orig
	sed -e "s:= -g -W #-Wall:= ${CXXFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe idesk
	dodoc README
	newman ${FILESDIR}/idesk05.1 idesk.1
	newman ${FILESDIR}/ideskrc05.5 ideskrc.5
}

pkg_postinst() {
	einfo
	einfo "NOTE: Please refer to ${HOMEPAGE}"
	einfo "NOTE: For info on configuring ${PN}"
	einfo
}
