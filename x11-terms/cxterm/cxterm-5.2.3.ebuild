# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/cxterm/cxterm-5.2.3.ebuild,v 1.1 2004/01/26 17:35:52 pyrania Exp $

S="${WORKDIR}/${P}"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://cxterm.sourceforge.net/"
DESCRIPTION="A Chinese/Japanese/Korean X-Terminal"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

# hyper-optimizations untested...
#
src_compile() {

	cd ${S}
	sed "s/genCxterm/\.\/genCxterm/g" ${S}/scripts/Makefile.in > ${S}/scripts/Makefile.new
	mv ${S}/scripts/Makefile.new ${S}/scripts/Makefile.in

	./configure --prefix=/usr \
				--mandir=/usr/share/man \
				--infodir=/usr/share/info || die "./configure failed"

	make CFLAGS="${CFLAGS}" || die

}

src_install() {

	emake \
			prefix=${D}/usr \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			install || die

	dodoc README-5.2 INSTALL-5.2 Doc/*
	docinto tutorial-1
	dodoc Doc/tutorial-1/*
	docinto tutorial-2
	dodoc Doc/tutorial-2/*
}
