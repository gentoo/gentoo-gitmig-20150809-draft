# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/passivetex/passivetex-1.4.ebuild,v 1.11 2003/09/05 22:37:22 msterret Exp $

S=${WORKDIR}/passivetex
DESCRIPTION="A namespace-aware XML parser written in Tex"
SRC_URI="http://users.ox.ac.uk/~rahtz/passivetex/${PN}.zip"
HOMEPAGE="http://users.ox.ac.uk/~rahtz/passivetex/"
KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="freedist"

DEPEND="app-text/tetex app-arch/unzip"
RDEPEND="app-text/tetex"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	cp ${FILESDIR}/${P}-Makefile Makefile
}

src_compile() {
	make || die
}

src_install () {

	make DESTDIR=${D} install || die

}

pkg_postinst() {
	if [ -e /usr/bin/mktexlsr ]
	then
		/usr/bin/mktexlsr
	fi
}
