# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libemf/libemf-1.0.ebuild,v 1.4 2004/02/18 11:02:08 phosphan Exp $

MY_P="${P/emf/EMF}"

DESCRIPTION="Library implementation of ECMA-234 API for the generation of enhanced metafiles."
HOMEPAGE="http://libemf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND=""

inherit gcc

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	if [ $(gcc-major-version) -ge 3 ]; then
		einfo "gcc >= 3, patch needed"
		patch -p0 < ${FILESDIR}/${MY_P}-gcc3.patch || die "patch failed"
	fi
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
