# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sgb/sgb-20030623.ebuild,v 1.4 2005/05/07 17:44:13 dholm Exp $

DESCRIPTION="Stanford GraphBase"
HOMEPAGE="ftp://labrea.stanford.edu/pub/sgb/"
SRC_URI="ftp://labrea.stanford.edu/pub/sgb/sgb-${PV:0:4}-${PV:4:2}-${PV:6:2}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-util/cweb-3.00"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	echo >>Makefile
	echo 'demos: $(DEMOS)' >>Makefile
}

src_compile() {
	emake SGBDIR=/usr/share/${PN} \
	INCLUDEDIR=/usr/include/sgb \
	LIBDIR=/usr/lib \
	BINDIR=/usr/bin \
	CWEBINPUTS=/usr/share/${PN}/cweb \
	CFLAGS="${CFLAGS}" tests lib demos
}

src_install() {
	dodir /usr/share/${PN} /usr/include/sgb /usr/lib /usr/bin /usr/share/${PN}/cweb
	emake SGBDIR=${D}/usr/share/${PN} \
	INCLUDEDIR=${D}/usr/include/sgb \
	LIBDIR=${D}/usr/lib \
	BINDIR=${D}/usr/bin \
	CWEBINPUTS=${D}/usr/share/${PN}/cweb \
	CFLAGS="${CFLAGS}" install installdata installdemos
	# we don't need no makefile
	rm ${D}/usr/include/sgb/Makefile

	dodoc ERRATA README

}
