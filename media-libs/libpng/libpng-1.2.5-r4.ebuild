# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.5-r4.ebuild,v 1.7 2003/04/24 22:57:29 azarah Exp $

inherit flag-o-matic eutils

DESCRIPTION="Portable Network Graphics library"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.libpng.org/"

SLOT="1.2"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa arm mips"

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.diff

	replace-flags "-march=k6-3" "-march=i586"
	replace-flags "-march=k6-2" "-march=i586"
	replace-flags "-march=k6" "-march=i586"

	sed -e "s:ZLIBLIB=.*:ZLIBLIB=/usr/lib:" \
		-e "s:ZLIBINC=.*:ZLIBINC=/usr/include:" \
		-e "s:-O3:${CFLAGS}:" \
		-e "s:prefix=/usr/local:prefix=/usr:" \
		-e "s:OBJSDLL = :OBJSDLL = -lz -lm :" \
			scripts/makefile.linux > Makefile
}

src_compile() {
	emake CC="${CC:-gcc}" CXX="${CXX:-g++}" || die "Make failed"
}

src_install() {
	dodir /usr/{include,lib}
	dodir /usr/share/man
	einstall MANPATH=${D}/usr/share/man|| die "Failed to install"

	doman libpng.3 libpngpf.3 png.5
	dodoc ANNOUNCE CHANGES KNOWNBUG LICENSE README TODO Y2KINFO
}

pkg_postinst() {
	# the libpng authors really screwed around between 1.2.1 and 1.2.3
	[ -f /usr/lib/libpng.so.3.1.2.1 ] && rm /usr/lib/libpng.so.3.1.2.1
}
