# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.5-r3.ebuild,v 1.3 2004/03/19 07:56:04 mr_bones_ Exp $

inherit flag-o-matic eutils

S=${WORKDIR}/${P}
DESCRIPTION="Portable Network Graphics library"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.libpng.org/"

SLOT="1.2"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"

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
	emake || die
}

src_install() {
	dodir /usr/{include,lib}
	dodir /usr/share/man
	make \
		DESTDIR=${D} \
		MANPATH=/usr/share/man \
		install || die

	doman *.[35]
	dodoc ANNOUNCE CHANGES KNOWNBUG LICENSE README TODO Y2KINFO
}

pkg_postinst() {
	# the libpng authors really screwed around between 1.2.1 and 1.2.3
	[ -f /usr/lib/libpng.so.3.1.2.1 ] && rm /usr/lib/libpng.so.3.1.2.1
}
