# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-3.41.ebuild,v 1.8 2004/06/28 16:07:10 vapier Exp $

inherit eutils

DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	if [ "${ARCH}" = "mips" ]; then
		cd ${S}
		epatch ${FILESDIR}/${P}-mips-gentoo.diff || die
	fi
}

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share/misc \
		--host=${CHOST} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	if ! use build ; then
		dodoc LEGAL.NOTICE MAINT README
	else
		rm -rf ${D}/usr/share/man
	fi
}
