# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-2.0.ebuild,v 1.1 2005/07/28 20:58:01 sekretarz Exp $

MY_P=${P/_/-}
S=${WORKDIR}/${P%%_*}
DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.kdown1.de/files/${MY_P}-src.tgz"
HOMEPAGE="http://www.klografx.net/qiv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="xinerama"

DEPEND="media-libs/libpng
	>=media-libs/tiff-3.5.5
	>=media-libs/imlib-1.9.10
	virtual/x11"

src_compile() {
	use xinerama && sed -i "s:# GTD_XINERAMA = -DGTD_XINERAMA:GTD_XINERAMA = -DGTD_XINERAMA:" Makefile
	make || die
}

src_install () {
	into /usr
	dobin qiv
	doman qiv.1
	dodoc README*
}
