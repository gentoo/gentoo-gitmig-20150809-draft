# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2x/x2x-1.27-r2.ebuild,v 1.1 2006/04/14 18:55:08 nelchael Exp $

inherit eutils

DESCRIPTION="An utility to connect the Mouse and KeyBoard to another X"
HOMEPAGE="http://www.the-labs.com/X11/#x2x"
LICENSE="as-is"
SRC_URI="http://ftp.digital.com/pub/Digital/SRC/x2x/${P}.tar.gz
	mirror://debian/pool/main/x/x2x/x2x_1.27-8.diff.gz
	mirror://gentoo/x2x_1.27-8-initvars.patch.gz
	mirror://gentoo/${P}-license.patch.gz
	mirror://gentoo/${P}-keymap.diff.gz"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
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

	# Patch from Debian to add -north and -south, among other fixes
	epatch ${DISTDIR}/x2x_1.27-8.diff.gz

	# Fix variable initialization in Debian patch
	epatch ${DISTDIR}/x2x_1.27-8-initvars.patch.gz

	# Patch to add LICENSE
	epatch ${DISTDIR}/${P}-license.patch.gz

	# Patch to fix bug #126939
	# AltGr does not work in x2x with different keymaps:
	epatch ${DISTDIR}/${P}-keymap.diff.gz

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
