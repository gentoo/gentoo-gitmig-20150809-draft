# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim-modules/naim-modules-0.0.11.6.1_pre20030923.ebuild,v 1.2 2004/02/22 22:43:59 agriffis Exp $

MY_PV="${PV/_pre*}-2003-09-23-1113"
DESCRIPTION="a bunch of modules for the naim im client"
HOMEPAGE="http://site.n.ml.org/info/naim/"
SRC_URI="http://site.n.ml.org/download/20031011213921/naim/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips ~alpha ~hppa ia64 ~amd64"
IUSE="debug"

DEPEND="net-im/naim"

S=${WORKDIR}/${P/_pre*}

src_compile() {
	econf --with-pkgdocdir=/usr/share/doc/${PF} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
