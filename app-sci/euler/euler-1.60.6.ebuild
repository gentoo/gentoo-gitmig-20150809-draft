# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/euler/euler-1.60.6.ebuild,v 1.4 2003/02/13 09:21:27 vapier Exp $

IUSE=""

#euler only uses two major numners internally, need to do some mangling
MajVer="$(echo ${PV}|cut -d '.' -f 1,2)"
S=${WORKDIR}/${PN}-${MajVer}

DESCRIPTION="Mathematical programming environment"
SRC_URI="mirror://sourceforge/euler/${P}.tar.gz"
HOMEPAGE="http://euler.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc
	virtual/x11
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}/source
	mv main.c main.c.orig
	cat main.c.orig | \
	sed -e "s:share/euler/docs/index.html:share/doc/${P}/html/index.html:" \
		> main.c
}

src_compile() {
	cd ${S}/source
	emake INSTALL_DIR=/usr || die
}

src_install () {
	cd ${S}/source
	dodir usr usr/share usr/bin
	make INSTALL_DIR=${D}/usr install || die

	cd ${S}
	dodir usr/share/doc/${P}/html
	mv ${D}/usr/share/doc/${PN}/* ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/share/doc/${PN}
	dodoc ChangeLog README TODO
}

