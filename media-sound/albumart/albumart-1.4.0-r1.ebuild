# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/albumart/albumart-1.4.0-r1.ebuild,v 1.1 2005/02/22 21:01:30 carlo Exp $

inherit eutils

IUSE=""

DESCRIPTION="Album Cover Art Downloader"
SRC_URI="http://kempele.fi/~skyostil/projects/albumart/dist/${P}.tar.gz"
HOMEPAGE="http://kempele.fi/~skyostil/projects/albumart/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"

DEPEND=">=dev-python/PyQt-3.0
	>=dev-python/imaging-1.0.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sizetype.patch
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	python setup.py install --root= --prefix=/${D}usr || die
}
