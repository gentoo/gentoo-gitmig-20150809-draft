# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.31-r1.ebuild,v 1.4 2002/07/23 05:18:07 seemant Exp $

# nonstandard archive name and source dir
MY_P=${P//[-.]/_}
S=${WORKDIR}/${P/-/_}
DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
SRC_URI="http://home.t-online.de/home/helga.glunz/wglunz/${PN}/${MY_P}.zip"
HOMEPAGE="http://www.pstoedit.net/pstoedit"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-libs/libpng
	sys-libs/zlib"

RDEPEND="$DEPEND
	app-text/ghostscript"

src_compile() {
	cd ${S}/config
	econf || die "./configure failed"

	cd ${S}/src
	emake || die "emake failed"
}

src_install () {
	dodoc readme.txt copying changelog.htm
	cd ${S}/src
	make DESTDIR=${D} install || die "make install failed"
}
