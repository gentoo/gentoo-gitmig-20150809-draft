# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/albumart/albumart-1.5.0-r1.ebuild,v 1.3 2006/01/05 09:02:56 chriswhite Exp $

inherit eutils qt3

DESCRIPTION="Album Cover Art Downloader"
SRC_URI="http://kempele.fi/~skyostil/projects/albumart/dist/${P}.tar.gz"
HOMEPAGE="http://kempele.fi/~skyostil/projects/albumart/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-python/PyQt-3.0
	>=dev-python/imaging-1.0.0"

src_compile() {
	cd ${S}/lib/albumart
	emake || die "Failed to compile python UIs."
}

src_install() {
	python setup.py install --root= --prefix=/${D}usr || die
}
