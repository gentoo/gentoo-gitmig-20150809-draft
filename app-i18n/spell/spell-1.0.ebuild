# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: José Alberto Suárez López <bass@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/spell/spell-1.0.ebuild,v 1.1 2002/05/30 19:16:16 bass Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="A spell checking program implemented as a wrapper for ispell."
SRC_URI="http://sunsite.doc.ic.ac.uk/pub/Mirrors/ftp.gnu.org/pub/gnu/spell/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/spell.html"
LICENSE="GPL-2"
DEPEND="app-text/ispell"
RDEPEN="${DEPEND}"
SLOT="0"

src_compile() {
    ./configure \
	     --host=${CHOST} \
	     --prefix=/usr \
	     --infodir=${D}/usr/share/info \
	     --mandir=${D}/usr/share/man || die	"./configure failed"
    emake || die
}
src_install () {
    make prefix=${D}/usr install || die
}

pkg_postinstall () {
	rm /usr/share/info/spell.info
}
