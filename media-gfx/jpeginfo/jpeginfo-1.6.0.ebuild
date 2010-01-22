# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpeginfo/jpeginfo-1.6.0.ebuild,v 1.18 2010/01/22 17:34:11 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Prints information and tests integrity of JPEG/JFIF files."
HOMEPAGE="http://www.cc.jyu.fi/~tjko/projects.html"
SRC_URI="http://www.cc.jyu.fi/~tjko/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=">=media-libs/jpeg-6b:0"

src_configure() {
	tc-export CC
	econf
}

src_install() {
	# bug #294820
	emake -j1 INSTALL_ROOT="${D}" install || die
	dodoc README
}
