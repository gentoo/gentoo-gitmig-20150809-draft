# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/potracegui/potracegui-1.3.4-r1.ebuild,v 1.3 2009/10/10 18:58:39 pva Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="Potracegui is a GUI interface for potrace and autotrace, two programs for tracing bitmapped images."
HOMEPAGE="http://potracegui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-gfx/autotrace
	media-gfx/potrace"
need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" "${FILESDIR}/${P}-kdelibs4-build.patch" )

src_unpack() {
	kde_src_unpack
	rm "${S}"/configure
}
