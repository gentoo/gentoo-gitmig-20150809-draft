# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.8.ebuild,v 1.8 2004/01/02 13:18:10 vapier Exp $

inherit gcc

S=${WORKDIR}/${P}
DESCRIPTION="Console display library used by most text viewer"
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${P}.tar.bz2"
LICENSE="GPL-2 | Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm ~amd64"
SLOT="0"
HOMEPAGE="http://space.mit.edu/~davis/slang/"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_compile() {
	econf || die "econf failed"
	# emake doesn't work well with slang, so just use normal make.
	make all elf || die "make failed"
}

src_install() {
	make install install-elf DESTDIR=${D} || die "make install failed"
	( cd ${D}/usr/lib ; chmod 755 libslang.so.* )
	# remove the documentation... we want to install it ourselves
	rm -rf ${D}/usr/doc
	dodoc COPYING* NEWS README *.txt
	dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
	dohtml doc/*.html
}

pkg_postinst() {
	# ensure gcc uses the most recent slang.h (#16678)
	if [ "`gcc-major-version`" = "3" ]; then
		if [ -f "`gcc-libpath`/include/slang.h" ]; then
			einfo "Removing gcc buffered slang.h to avoid conflicts"
			rm -f `gcc-libpath`/include/slang.h
		fi
	fi
}
