# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdupes/fdupes-1.40.ebuild,v 1.2 2003/06/29 23:17:15 aliz Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Program for identifying or deleting duplicate files residing within specified directories."
SRC_URI="http://netdial.caribe.net/~adrian2/programs/${P}.tar.gz"
HOMEPAGE="http://netdial.caribe.net/~adrian2/fdupes.html"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86"

DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	dobin fdupes
	doman fdupes.1
	dodoc CHANGES CONTRIBUTORS INSTALL README TODO
}

