# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gxemul/gxemul-0.6.0.ebuild,v 1.2 2011/04/22 12:32:02 jlec Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A Machine Emulator, Mainly emulates MIPS, but supports other CPU types"
HOMEPAGE="http://gxemul.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/gxemul/GXemul/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="debug X"

RDEPEND="X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}
	X? ( x11-proto/xproto )"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gcc46.patch
	sed -i configure -e 's|-O3||g' || die "sed configure"
	tc-export CC CXX
}

src_configure() {
	# no autotools
	./configure \
		--disable-valgrind \
		$(use debug && echo --debug) \
		$(use X || echo --disable-x) || die "configure failed"
}

src_install() {
	dobin gxemul
	doman man/gxemul.1
	dodoc HISTORY README
	dohtml -r doc/*
}
