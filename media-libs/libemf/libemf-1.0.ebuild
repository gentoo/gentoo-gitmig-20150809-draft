# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libemf/libemf-1.0.ebuild,v 1.3 2004/02/15 13:17:04 darkspecter Exp $

MY_P="${P/emf/EMF}"

DESCRIPTION="Library implementation of ECMA-234 API for the generation of enhanced metafiles."
HOMEPAGE="http://libemf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${MY_P}-gcc3.patch || die "patch failed"
}

src_compile() {
	econf --enable-editing
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dohtml doc/html/*
	dodoc README NEWS AUTHORS ChangeLog
}
