# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.9.ebuild,v 1.24 2004/10/23 05:42:08 mr_bones_ Exp $

DESCRIPTION="Console display library used by most text viewer"
HOMEPAGE="http://space.mit.edu/~davis/slang/"
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${P}.tar.bz2"

LICENSE="GPL-2 | Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ppc-macos"
IUSE="cjk"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_compile() {
	if use cjk
	then
		# enable Kanji Support
		cp src/sl-feat.h src/sl-feat.h.bak
		sed "/SLANG_HAS_KANJI_SUPPORT/s/0/1/" \
			src/sl-feat.h.bak > src/sl-feat.h
	fi
	econf || die "econf failed"
	# emake doesn't work well with slang, so just use normal make.
	make all elf || die "make failed"
}

src_install() {
	make install install-elf DESTDIR=${D} || die "make install failed"
	( cd ${D}/usr/$(get_libdir) ; chmod 755 libslang.so.* )
	# remove the documentation... we want to install it ourselves
	rm -rf ${D}/usr/doc
	dodoc NEWS README *.txt
	dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
	dohtml doc/*.html
}
