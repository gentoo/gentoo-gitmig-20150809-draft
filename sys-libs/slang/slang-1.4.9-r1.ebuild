# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.9-r1.ebuild,v 1.13 2004/11/02 14:50:00 vapier Exp $

inherit gcc eutils

DESCRIPTION="Console display library used by most text viewer"
HOMEPAGE="http://space.mit.edu/~davis/slang/"
# Patches are taken from http://www.suse.de/~nadvornik/slang/
# They were originally Red Hat and Debian's patches
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${P}.tar.bz2"

LICENSE="GPL-2 | Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
IUSE="cjk unicode"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}

	epatch ${FILESDIR}/${P}.dif
	epatch ${FILESDIR}/${P}-fsuid.dif
	epatch ${FILESDIR}/${P}-autoconf.dif
	if use unicode ; then
		epatch ${FILESDIR}/slang-debian-utf8.patch
		epatch ${FILESDIR}/slang-utf8-acs.patch
		epatch ${FILESDIR}/slang-utf8-fix.patch
	fi
	if use cjk ; then
		# enable Kanji Support
		cp src/sl-feat.h src/sl-feat.h.bak
		sed "/SLANG_HAS_KANJI_SUPPORT/s/0/1/" \
			src/sl-feat.h.bak > src/sl-feat.h
	fi
}

src_compile() {
	econf || die "econf failed"
	# emake doesn't work well with slang, so just use normal make.
	make all elf || die "make failed"
}

src_install() {
	make install install-elf DESTDIR=${D} || die "make install failed"
	use ppc-macos || fperms 755 /usr/$(get_libdir)/libslang.so.*

	if use unicode ; then
		for i in ${D}/usr/$(get_libdir)/libslang-utf8* ; do
			local libslang=${i/${D}/}
			dosym ${libslang} ${libslang/-utf8/}
		done
		dosym /usr/$(get_libdir)/libslang{-utf8,}.a
	fi

	# remove the documentation... we want to install it ourselves
	rm -rf ${D}/usr/doc
	dodoc COPYING* NEWS README *.txt
	dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
	dohtml doc/*.html
}
