# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cvoicecontrol/cvoicecontrol-0.9_alpha.ebuild,v 1.6 2003/09/07 00:06:04 msterret Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Console based speech recognition system"
HOMEPAGE="http://www.kiecza.de/daniel/linux/cvoicecontrol/index.html"
SRC_URI="http://www.kiecza.de/daniel/linux/${MY_P}.tar.bz2"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}

	patch -p0 <${FILESDIR}/${P}-gentoo.diff || die

	#remove "docs" from SUBDIRS in Makefile.in
	#Makefile will try to install few html files directly under the /usr
	#much easier to do with dohtml
	cd ${S}/cvoicecontrol/
	mv Makefile.in Makefile.in-orig
	sed -e "s:SUBDIRS = docs:#SUBDIRS = docs:" Makefile.in-orig > Makefile.in

	cd ${S}
	mv Makefile.in Makefile.in-orig
	sed -e "s/install-data-am: install-data-local/install-data-am:/" Makefile.in-orig > Makefile.in
}


src_install () {
	make DESTDIR=${D} install || die

	#install documentation
	dodoc AUTHORS BUGS COPYING ChangeLog FAQ README
	dohtml cvoicecontrol/docs/en/*.html
}
