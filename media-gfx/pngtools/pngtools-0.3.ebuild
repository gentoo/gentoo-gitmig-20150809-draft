# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngtools/pngtools-0.3.ebuild,v 1.3 2007/07/12 04:08:47 mr_bones_ Exp $

MY_PV="${PV/./_}"

DESCRIPTION="A series of tools for the PNG image format"
HOMEPAGE="http://www.stillhq.com/pngtools/"
SRC_URI="http://www.stillhq.com/pngtools/source/pngtools_${MY_PV}.tgz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=media-libs/libpng-1.2.8-r1
		virtual/libc"

src_install() {
	emake -j1 install DESTDIR="${D}" || die "emake install failed"
	dodoc ABOUT AUTHORS ChangeLog NEWS README chunks.txt *.png
}
