# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/evilwm/evilwm-0.99.17.ebuild,v 1.14 2006/01/31 11:50:03 tove Exp $

MY_P="${PN}_${PV}.orig"
S=${WORKDIR}/${MY_P/_/-}

DESCRIPTION="A minimalist, no frills window manager for X."
SRC_URI="http://download.sourceforge.net/evilwm/${MY_P}.tar.gz"
HOMEPAGE="http://evilwm.sourceforge.net"

IUSE="motif"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha amd64"

RDEPEND="|| ( x11-libs/libXext virtual/x11 )
	motif? ( x11-libs/openmotif )"

DEPEND="${RDEPEND}
	|| ( (  x11-proto/xextproto
			x11-proto/xproto )
		virtual/x11 )"

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -i 's/^#define DEF_FONT.*/#define DEF_FONT "fixed"/' evilwm.h
	if ! use motif
	then
		cp Makefile ${T}
		sed "s:DEFINES += -DMWM_HINTS::" \
			${T}/Makefile > Makefile
	fi
}

src_compile() {
	emake allinone || die
}

src_install () {
	exeinto /usr/bin
	doexe evilwm

	doman evilwm.1
	dodoc ChangeLog README* INSTALL TODO
}
