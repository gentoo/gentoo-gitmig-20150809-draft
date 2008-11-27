# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpeginfo/jpeginfo-1.6.0.ebuild,v 1.14 2008/11/27 21:39:21 jer Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="Prints information and tests integrity of JPEG/JFIF files."
HOMEPAGE="http://www.cc.jyu.fi/~tjko/projects.html"
SRC_URI="http://www.cc.jyu.fi/~tjko/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

DEPEND=">=media-libs/jpeg-6b"

tc-export CC

src_install() {
	make INSTALL_ROOT="${D}" install || die

	dodoc COPY* README
}
