# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.5-r8.ebuild,v 1.3 2004/08/05 10:22:53 ciaranm Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-security.diff
	use macos && epatch ${FILESDIR}/macos.patch # implements strnlen

	[ "`gcc-version`" == "3.2" ] && replace-cpu-flags i586 k6 k6-2 k6-3
	[ "`gcc-version`" == "3.3" ] && replace-cpu-flags i586 k6 k6-2 k6-3

	sed \
		-e "s:ZLIBLIB=.*:ZLIBLIB=/usr/lib:" \
		-e "s:ZLIBINC=.*:ZLIBINC=/usr/include:" \
		-e "s:-O3:${CFLAGS}:" \
		-e "s:prefix=/usr/local:prefix=/usr:" \
		-e "s:OBJSDLL = :OBJSDLL = -lz -lm :" \
		scripts/makefile.linux > Makefile

	if use macos; then
		einfo "Patching the source for Mac OS X / Darwin compatibility"
		sed \
			-e "s:ZLIBLIB=.*:ZLIBLIB=/usr/lib:" \
			-e "s:ZLIBINC=.*:ZLIBINC=/usr/include:" \
			-e "s:-O3:${CFLAGS}:" \
			-e "s:prefix=/usr/local:prefix=/usr:" \
			scripts/makefile.darwin > Makefile
	fi
}

src_compile() {
	emake CC="$(gcc-getCC)" CXX="$(gcc-getCXX)" || die "Make failed"
}

src_install() {
	dodir /usr/{include,lib}
	dodir /usr/share/man
	einstall MANPATH=${D}/usr/share/man || die "Failed to install"

	doman libpng.3 libpngpf.3 png.5
	dodoc ANNOUNCE CHANGES KNOWNBUG README TODO Y2KINFO
}

pkg_postinst() {
	# the libpng authors really screwed around between 1.2.1 and 1.2.3
	[ -f ${ROOT}/usr/lib/libpng.so.3.1.2.1 ] && rm ${ROOT}/usr/lib/libpng.so.3.1.2.1
}
