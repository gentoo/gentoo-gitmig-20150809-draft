# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/lletters/lletters-0.1.95.ebuild,v 1.1 2003/09/10 04:51:18 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Game that helps young kids learn their letters and numbers"
SRC_URI="mirror://sourceforge/lln/lletters-media-0.1.9a.tar.gz
mirror://sourceforge/lln/${P}.tar.gz"
HOMEPAGE="http://lln.sourceforge.net/"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/x11
	media-libs/imlib
	x11-libs/gtk+"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}
	unpack lletters-media-0.1.9a.tar.gz
}

src_compile() {
	./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man || die
	emake || die
}

src_install () {
	make prefix=${D}/usr infodir=${D}/usr/share/info mandir=${D}/usr/share/man install || die

}
