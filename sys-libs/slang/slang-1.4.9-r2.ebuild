# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.9-r2.ebuild,v 1.12 2006/04/24 01:56:57 kumba Exp $

inherit eutils

# Patches are taken from http://www.suse.de/~nadvornik/slang/
# They were originally Red Hat and Debian's patches

DESCRIPTION="Console display library used by most text viewer"
HOMEPAGE="http://www.s-lang.org/"
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${P}.tar.bz2
	mirror://gentoo/${P}-patches.tar.gz"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 mips ppc ~ppc-macos ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="cjk unicode"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${P}.patch
	use ppc-macos || epatch ${WORKDIR}/${P}-fsuid.patch
	epatch ${WORKDIR}/${P}-autoconf.patch
	if use unicode ; then
		epatch ${WORKDIR}/slang-debian-utf8.patch
		epatch ${WORKDIR}/slang-utf8-acs.patch
		epatch ${WORKDIR}/slang-utf8-fix.patch
		epatch ${WORKDIR}/slang-utf8-fix2.patch
	fi

	epatch "${FILESDIR}/${P}-fbsdlink.patch"

	if use cjk ; then
		sed -i \
			-e "/SLANG_HAS_KANJI_SUPPORT/s/0/1/" \
			src/sl-feat.h
	fi
}

src_compile() {
	export LANG=C
	export LC_ALL=C
	econf || die "econf failed"
	emake -j1 all elf || die "make failed"
}

src_install() {
	make install install-elf DESTDIR=${D} || die "make install failed"
	if use ppc-macos ; then
		chmod a+rx "${D}"/usr/$(get_libdir)/libslang*dylib || die "chmod failed"
	else
		chmod a+rx "${D}"/usr/$(get_libdir)/libslang*so* || die "chmod failed"
	fi

	if use unicode ; then
		for i in ${D}/usr/$(get_libdir)/libslang-utf8* ; do
			local libslang=${i/${D}/}
			dosym ${libslang} ${libslang/-utf8/}
		done
		dosym /usr/$(get_libdir)/libslang{-utf8,}.a
	fi

	rm -rf ${D}/usr/doc
	dodoc NEWS README *.txt
	dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
	dohtml doc/*.html
}
