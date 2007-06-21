# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pstotext/pstotext-1.9-r2.ebuild,v 1.8 2007/06/21 15:24:28 jer Exp $

inherit eutils

DESCRIPTION="extract ASCII text from a PostScript or PDF file"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/doc/pstotext.htm"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/contrib/${P}.tar.gz"

LICENSE="PSTT"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND="app-arch/ncompress"

RDEPEND="virtual/ghostscript"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix bug #132662
	epatch "${FILESDIR}"/${P}-quote-chars-fix.patch || die
}

src_compile() {
	emake || die
}

src_install () {
	into /usr
	dobin pstotext
	doman pstotext.1
}
