# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/albumart/albumart-1.6.0.ebuild,v 1.1 2006/01/03 19:24:42 carlo Exp $

inherit eutils qt3

DESCRIPTION="Album Cover Art Downloader"
SRC_URI="http://kempele.fi/~skyostil/projects/albumart/dist/${P}.tar.gz"
HOMEPAGE="http://kempele.fi/~skyostil/projects/albumart/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-python/PyQt-3.14.1-r1
	>=dev-python/imaging-1.0.0"

src_compile() {
	cd ${S}/lib/albumart
	emake || die "Failed to compile python UIs."
}

src_install() {
	python setup.py install --root=${D} --prefix=${ROOT}usr || die
}
