# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.0.12.ebuild,v 1.4 2002/10/04 03:56:12 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Awesome CD burning frontend"
SLOT="0"
SRC_URI="ftp://eclipt.uni-klu.ac.at/pub/projects/eroaster/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="*"

HOMEPAGE="http://eclipt.uni-klu.ac.at/eroaster.php"
DEPEND=">=dev-lang/python-2.0
	app-cdr/cdrtools
	dev-python/gnome-python"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

}

