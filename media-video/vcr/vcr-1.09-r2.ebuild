# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcr/vcr-1.09-r2.ebuild,v 1.4 2003/02/21 18:11:22 mholzer Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="VCR - Linux Console VCR"
SRC_URI="http://www.stack.nl/~brama/${PN}/src/${P}.tar.gz"
HOMEPAGE="http://www.stack.nl/~brama/vcr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=media-video/avifile-0.7.15*"

src_unpack () {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/1.09-r2-gentoo.diff || die "patch failed"

}

src_compile () {

	local myconf
	myconf="--enable-avifile-0_6"

	export CXX="g++"

	econf ${myconf} || die "econf died"

	make || die "emake died"

}

src_install () {

	einstall || die "einstall died"

	dodoc AUTHORS COPYING ChangeLog NEWS README

}
