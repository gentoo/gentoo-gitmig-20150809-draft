# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cvoicecontrol/cvoicecontrol-0.9_alpha.ebuild,v 1.11 2004/07/12 22:45:32 eradicator Exp $

inherit eutils

IUSE=""

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Console based speech recognition system"
HOMEPAGE="http://www.kiecza.de/daniel/linux/cvoicecontrol/index.html"
SRC_URI="http://www.kiecza.de/daniel/linux/${MY_P}.tar.bz2"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
# ~sparc, ~amd64: 0.9_alpha: Builds fine on these systems, but I lack the 
# ability to test, so it will remain in ~arch until I get good user feedback
# If you use this on amd64 or sparc, please contact me.  --eradicator
KEYWORDS="x86 ~amd64 ~sparc"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.diff

	#remove "docs" from SUBDIRS in Makefile.in
	#Makefile will try to install few html files directly under the /usr
	#much easier to do with dohtml
	cd ${S}/cvoicecontrol/
	sed -i "s:SUBDIRS = docs:#SUBDIRS = docs:" Makefile.in

	cd ${S}
	sed -i "s/install-data-am: install-data-local/install-data-am:/" Makefile.in
}


src_install () {
	make DESTDIR=${D} install || die

	#install documentation
	dodoc AUTHORS BUGS COPYING ChangeLog FAQ README
	dohtml cvoicecontrol/docs/en/*.html
}
