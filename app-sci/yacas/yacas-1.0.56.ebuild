# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/yacas/yacas-1.0.56.ebuild,v 1.6 2004/11/29 11:48:42 phosphan Exp $

inherit eutils

IUSE="gmp"

DESCRIPTION="very powerful general purpose Computer Algebra System"
HOMEPAGE="http://yacas.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/backups/${P}.tar.gz
		mirror://gentoo/${P}.patch.bz2
		http://dev.gentoo.org/~phosphan/${P}.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	gmp? ( >=dev-libs/gmp-4 ) "


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}.patch
}

src_compile() {
	local myconf
	if use gmp ; then
		myconf="--with-numlib=gmp"
	fi
	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	# a very strange Makefile's, that do not honor standard wrappings :(
	find -name Makefile |xargs sed -i -e "s:datadir = /usr/share:datadir = ${D}/usr/share:"
	cd manmake
	sed -i -e "s:htmldir = :htmldir = ${D}:" -e "s:psdir = :psdir = ${D}:" Makefile
	cd ${S}

	DESTDIR=${D} make install-strip || die

	dodoc AUTHORS INSTALL NEWS README TODO
	mv ${D}/usr/share/${PN}/documentation ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/include/
}
