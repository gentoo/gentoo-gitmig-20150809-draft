# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/euler/euler-1.59.1.ebuild,v 1.12 2003/09/06 22:23:05 msterret Exp $

DESCRIPTION="Mathematical programming environment"
HOMEPAGE="http://euler.sourceforge.net/"
SRC_URI="mirror://sourceforge/euler/euler-1.59.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/x11
	=x11-libs/gtk+-1.2*"
PROVIDE="app-misc/euler"

src_unpack() {
	unpack ${P}.tar.gz
	mv euler-1.59 ${P}

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

src_install() {
	cd ${S}/source
	dodir usr usr/share usr/bin
	make INSTALL_DIR=${D}/usr install || die

	cd ${S}
	dodir usr/share/doc/${P}/html
	mv ${D}/usr/share/euler/docs/* ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/share/euler/docs
	dodoc ChangeLog README TODO
}
