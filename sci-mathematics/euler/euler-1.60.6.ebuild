# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/euler/euler-1.60.6.ebuild,v 1.2 2005/01/11 17:16:25 gustavoz Exp $

inherit eutils
IUSE=""

#euler only uses two major numners internally, need to do some mangling
MajVer="$(echo ${PV}|cut -d '.' -f 1,2)"
S=${WORKDIR}/${PN}-${MajVer}

DESCRIPTION="Mathematical programming environment"
HOMEPAGE="http://euler.sourceforge.net/"
SRC_URI="mirror://sourceforge/euler/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc -sparc"

DEPEND="virtual/libc
	virtual/x11
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}/source
	epatch ${FILESDIR}/${P}.patch
	epatch ${FILESDIR}/euler-1.60-compound_statements.patch
	sed -e "s:share/euler/docs/index.html:share/doc/${P}/html/index.html:" \
		-i main.c
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
	mv ${D}/usr/share/doc/${PN}/* ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/share/doc/${PN}
	dodoc ChangeLog README TODO
}
