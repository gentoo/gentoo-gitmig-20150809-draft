# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gxemul/gxemul-0.6.0.ebuild,v 1.1 2010/09/20 21:00:38 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A Machine Emulator, Mainly emulates MIPS, but supports other CPU types."
HOMEPAGE="http://gxemul.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/gxemul/GXemul/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="X"

RDEPEND="X? ( x11-libs/libX11 )"

DEPEND="${RDEPEND}
	X? ( x11-proto/xproto )"

src_prepare() {
	sed -i configure -e 's|-O3||g' || die "sed configure"
}

src_configure() {
	tc-export CC CXX

	# no autotools
	./configure $(use X || echo --disable-x) || die "configure failed"
}

src_install() {
	dobin gxemul || die
	doman man/gxemul.1
	dodoc HISTORY README RELEASE TODO
	dohtml doc/*
}
