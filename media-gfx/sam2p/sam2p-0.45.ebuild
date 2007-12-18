# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sam2p/sam2p-0.45.ebuild,v 1.9 2007/12/18 19:18:26 jer Exp $

inherit toolchain-funcs

DESCRIPTION="Utility to convert raster images to EPS, PDF and many others"
HOMEPAGE="http://www.inf.bme.hu/~pts/sam2p/"
# The author refuses to distribute
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE="gif"
DEPEND="dev-lang/perl"
RDEPEND="virtual/libc"

RESTRICT="test"

src_compile() {
	# Makedep fails with distcc
	if has distcc ${FEATURES}; then
		die "disable FEATURES=distcc"
	fi
	econf --enable-lzw $(use_enable gif) || die "econf failed"
	emake -j1 || die "make failed"
}

src_install() {
	einstall
	dodoc README
}
