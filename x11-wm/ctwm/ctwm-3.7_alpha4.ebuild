# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ctwm/ctwm-3.7_alpha4.ebuild,v 1.1 2003/12/01 17:02:37 usata Exp $

IUSE=""

MY_P="${P/_/-}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A clean, light window manager."
#SRC_URI="http://ctwm.free.lp.se/dist/${MY_P}.tar.gz"
SRC_URI="http://ctwm.free.lp.se/preview/${MY_P}.tar.gz"
HOMEPAGE="http://ctwm.free.lp.se/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="MIT"

DEPEND="virtual/x11
	media-libs/jpeg"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	xmkmf || die
	make TWMDIR=/usr/share/${P} || die
}

src_install() {
	make BINDIR=/usr/bin \
		 MANPATH=/usr/share/man \
		 TWMDIR=/usr/share/${P} \
		 DESTDIR=${D} install || die

	make MANPATH=/usr/share/man \
		DOCHTMLDIR=/usr/share/doc/${PF}/html \
		DESTDIR=${D} install.man || die

	echo "#!/bin/sh" > ${T}/ctwm
	echo "/usr/bin/ctwm" >> ${T}/ctwm

	exeinto /etc/X11/Sessions
	doexe ${T}/ctwm

	dodoc CHANGES README* TODO* PROBLEMS
	dodoc *.ctwmrc*
}
