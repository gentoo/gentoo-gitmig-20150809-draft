# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/albumart/albumart-1.4.0.ebuild,v 1.1 2004/11/28 22:53:36 eradicator Exp $

IUSE=""

DESCRIPTION="Album Cover Art Downloader"
SRC_URI="http://kempele.fi/~skyostil/projects/albumart/dist/${P}.tar.gz"
HOMEPAGE="http://kempele.fi/~skyostil/projects/albumart/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"

DEPEND=">=dev-python/PyQt-3.0
	>=dev-python/imaging-1.0.0"

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	python setup.py install --root= --prefix=/${D}usr || die
}
