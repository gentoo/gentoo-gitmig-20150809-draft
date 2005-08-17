# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libsvg-cairo/libsvg-cairo-0.1.5.ebuild,v 1.5 2005/08/17 08:37:43 compnerd Exp $

DESCRIPTION="Render SVG content using cairo"
HOMEPAGE="http://xsvg.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sparc ~x86"
IUSE=""
DEPEND=">=x11-libs/cairo-0.3.0
	media-libs/libsvg"

src_install() {
	make install DESTDIR="${D}" || die
}
