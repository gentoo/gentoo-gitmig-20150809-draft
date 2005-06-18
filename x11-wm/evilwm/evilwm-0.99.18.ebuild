# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/evilwm/evilwm-0.99.18.ebuild,v 1.1 2005/06/18 18:23:16 usata Exp $

DESCRIPTION="A minimalist, no frills window manager for X."
SRC_URI="http://www.6809.org.uk/evilwm/${P}.tar.gz"
HOMEPAGE="http://evilwm.sourceforge.net"

IUSE="motif"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="virtual/x11
	motif? ( virtual/motif )"

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
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README* INSTALL TODO
}
