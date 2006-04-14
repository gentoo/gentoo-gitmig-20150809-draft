# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2x/x2x-1.27.ebuild,v 1.14 2006/04/14 18:55:08 nelchael Exp $

inherit eutils

DESCRIPTION="An utility to connect the Mouse and KeyBoard to another X"
HOMEPAGE="http://www.the-labs.com/X11/#x2x"
LICENSE="as-is"
SRC_URI="http://ftp.digital.com/pub/Digital/SRC/x2x/${P}.tar.gz
	mirror://gentoo/x2x-1.27-license.patch.gz"
SLOT="0"
KEYWORDS="x86 sparc alpha amd64 ~mips"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXtst
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		app-text/rman
		x11-misc/imake
		x11-proto/xproto )
	virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch to add LICENSE
	epatch ${DISTDIR}/x2x-1.27-license.patch.gz

	# Man-page is packaged as x2x.1 but needs to be x2x.man for building
	mv x2x.1 x2x.man || die
}

src_compile() {
	xmkmf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	newman x2x.man x2x.1 || die
	dodoc LICENSE || die
}
