# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ncompress/ncompress-4.2.4-r1.ebuild,v 1.4 2004/10/07 11:47:23 fmccor Exp $

inherit eutils

DESCRIPTION="Another uncompressor for compatibility"
HOMEPAGE="ftp://ftp.leo.org/pub/comp/os/unix/linux/sunsite/utils/compress/"
SRC_URI="ftp://ftp.leo.org/pub/comp/os/unix/linux/sunsite/utils/compress/${P}.tar.gz
	http://ftp.debian.org/debian/pool/main/n/ncompress/ncompress_4.2.4-15.diff.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ppc sparc ~mips alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="build"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ncompress-gcc34.patch
	# Add bounds checking for bug 66251
	epatch ${DISTDIR}/ncompress_4.2.4-15.diff.gz
}

src_compile() {
	sed -e "s:options= :options= ${CFLAGS} :" \
		-e "s:CC=cc:CC=${CC:-gcc}:" Makefile.def > Makefile
	make || die
}

src_install() {
	dobin compress || die
	dosym compress /usr/bin/uncompress
	use build || doman compress.1
}
