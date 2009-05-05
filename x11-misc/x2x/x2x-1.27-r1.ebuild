# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2x/x2x-1.27-r1.ebuild,v 1.12 2009/05/05 18:18:46 ssuominen Exp $

inherit eutils

DESCRIPTION="An utility to connect the Mouse and KeyBoard to another X"
HOMEPAGE="http://www.the-labs.com/X11/#x2x"
LICENSE="as-is"
SRC_URI="http://ftp.digital.com/pub/Digital/SRC/x2x/${P}.tar.gz
	mirror://debian/pool/main/x/x2x/x2x_1.27-8.diff.gz
	mirror://gentoo/x2x_1.27-8-initvars.patch.gz
	mirror://gentoo/x2x-1.27-license.patch.gz"
SLOT="0"
KEYWORDS="alpha ~amd64 ~mips ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	app-text/rman
	x11-misc/imake
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch from Debian to add -north and -south, among other fixes
	epatch "${DISTDIR}"/x2x_1.27-8.diff.gz

	# Fix variable initialization in Debian patch
	epatch "${DISTDIR}"/x2x_1.27-8-initvars.patch.gz

	# Patch to add LICENSE
	epatch "${DISTDIR}"/x2x-1.27-license.patch.gz

	# Man-page is packaged as x2x.1 but needs to be x2x.man for building
	mv x2x.1 x2x.man || die
}

src_compile() {
	xmkmf || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	newman x2x.man x2x.1 || die
}
