# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.5.9.ebuild,v 1.7 2004/01/08 09:32:38 aether Exp $

FOLDER="${P}"
SNAP=""

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="An ncurses AOL Instant Messenger."
# This source might change...
#SRC_URI="http://site.n.ml.org/download/20030607190139/${PN}/${P}.tar.gz"
SRC_URI="http://shell.n.ml.org/n/naim/${P}.tar.gz"
HOMEPAGE="http://naim.n.ml.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~alpha ~sparc"

DEPEND=">=sys-libs/ncurses-5.2"


src_compile() {
	einfo "${MY_P}"

	local myconf
	myconf="--with-gnu-ld --enable-detach"
	use static	&&	myconf="${myconf} --enable-static=yes"

	econf ${myconf}	|| die "configure failed"
	emake		|| die "make failed"
}

src_install() {
	dobin src/naim
	dosym /usr/bin/naim /usr/bin/nicq
	dosym /usr/bin/naim /usr/bin/nirc
	dosym /usr/bin/naim /usr/bin/nlily

	doman naim.1

	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README doc/*

	insinto /usr/share/${P}
	newins contrib/README.aimconvert README.aimconvert
	newins contrib/aimconvert.tcl aimconvert.tcl
	newins contrib/extractbuddy.sh extractbuddy.sh
	newins contrib/sendim.sh sendim.sh
	newins src/cmplhlp2.sh cmplhlp2.sh
	newins src/cmplhelp.sh cmplhelp.sh
	newins src/cmplsample.sh cmplsample.sh
	newins src/genkeys.sh genkeys.sh

	insinto /usr/include/${PN}
	newins include/modutil.h modutil.h
	newins include/naim.h naim.h
	newins include/config.h config.h

	dodir /usr/share/doc/naim
	insinto /usr/share/doc/naim
	doins ${S}/src/{commands,keyboard}.txt
	doins ${S}/doc/COLORS ${S}/FAQ
}
