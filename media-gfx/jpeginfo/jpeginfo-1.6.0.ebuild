# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpeginfo/jpeginfo-1.6.0.ebuild,v 1.8 2004/07/20 20:46:01 tgall Exp $

IUSE=""

DESCRIPTION="Prints information and tests integrity of JPEG/JFIF files."
HOMEPAGE="http://www.cc.jyu.fi/~tjko/projects.html"
SRC_URI="http://www.cc.jyu.fi/~tjko/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha ~amd64 ppc64"

DEPEND=">=media-libs/jpeg-6b"

src_install() {
	make INSTALL_ROOT=${D} install || die

	dodoc COPY* README
}
