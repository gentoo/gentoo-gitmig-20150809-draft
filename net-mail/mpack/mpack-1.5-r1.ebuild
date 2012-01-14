# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mpack/mpack-1.5-r1.ebuild,v 1.14 2012/01/14 18:44:57 armin76 Exp $

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="Command-line MIME encoding and decoding utilities"
HOMEPAGE="ftp://ftp.andrew.cmu.edu/pub/mpack/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/mpack/${P}-src.tar.Z"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}-src.tar.Z
	cd ${S}
	patch -l -p1 <${FILESDIR}/${P}-r1.patch || die "patch failed"
	epatch ${FILESDIR}/${P}-malloc-fix.patch || die "epatch failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dodir /usr
	make DESTDIR=${D}/usr install || die
	dodoc README.* SCOPTIONS
}
