# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/evilwm/evilwm-0.99.17.ebuild,v 1.12 2004/09/06 08:39:53 tigger Exp $

MY_P="${PN}_${PV}.orig"
S=${WORKDIR}/${MY_P/_/-}

DESCRIPTION="A minimalist, no frills window manager for X."
SRC_URI="http://download.sourceforge.net/evilwm/${MY_P}.tar.gz"
HOMEPAGE="http://evilwm.sourceforge.net"

IUSE="motif"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha ~amd64"

DEPEND="virtual/x11
	sys-apps/coreutils
	motif? ( x11-libs/openmotif )"

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
