# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pstotext/pstotext-1.8g.ebuild,v 1.2 2002/08/16 02:42:01 murphy Exp $

DESCRIPTION="extract ASCII text from a PostScript or PDF file"
HOMEPAGE="http://research.compaq.com/SRC/virtualpaper/pstotext.html"
SRC_URI="http://research.compaq.com/SRC/virtualpaper/binaries/pstotext.tar.Z"

LICENSE="PSTT"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="app-arch/ncompress"

RDEPEND=">=app-text/ghostscript-3.51"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
}

src_install () {
	into /usr
	dobin pstotext
	doman pstotext.1
}
