# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/cvoicecontrol/cvoicecontrol-0.9_alpha.ebuild,v 1.1 2002/06/22 01:07:04 george Exp $

S=${WORKDIR}/cvoicecontrol-0.9alpha
A=cvoicecontrol-0.9alpha.tar.bz2

DESCRIPTION="Console based speech recognition system"
HOMEPAGE="http://www.kiecza.de/daniel/linux/cvoicecontrol/index.html"
SRC_URI="http://www.kiecza.de/daniel/linux/${A}"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

LICENSE=""
SLOT="0"

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
