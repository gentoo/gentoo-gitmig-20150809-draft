# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.7.ebuild,v 1.5 2004/09/23 12:55:28 gustavoz Exp $

IUSE=""

inherit flag-o-matic eutils gcc

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="x86 ~ppc sparc ~arm ~hppa amd64 ~alpha ~mips ~macos ~ppc-macos"

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-gentoo.diff"

	if [ "$(gcc-version)" == "3.3" -o "$(gcc-version)" == "3.2" ] ; then
		replace-cpu-flags i586 k6 k6-2 k6-3
	fi

	if use macos || use ppc-macos ; then
		epatch "${FILESDIR}/macos.patch" # implements strnlen
		sed \
			-e "s:ZLIBLIB=.*:ZLIBLIB=/usr/$(get_libdir):" \
			-e "s:ZLIBINC=.*:ZLIBINC=/usr/include:" \
			-e "s:-O3:${CFLAGS}:" \
			-e "s:prefix=/usr/local:prefix=/usr:" \
			scripts/makefile.darwin > Makefile
	else
		sed \
			-e "s:ZLIBLIB=.*:ZLIBLIB=/usr/$(get_libdir):" \
			-e "s:ZLIBINC=.*:ZLIBINC=/usr/include:" \
			-e "s:-O3:${CFLAGS}:" \
			-e "s:prefix=/usr/local:prefix=/usr:" \
			-e "s:OBJSDLL = :OBJSDLL = -lz -lm :" \
			scripts/makefile.linux > Makefile
	fi
}

src_compile() {
	emake \
		CC="$(gcc-getCC)" \
		CXX="$(gcc-getCXX)" \
		|| die "emake failed"
}

src_install() {
	dodir /usr/include /usr/$(get_libdir) /usr/share/man
	make DESTDIR="${D}" MANPATH="/usr/share/man" LIBPATH="/usr/$(get_libdir)" install || die
	doman libpng.3 libpngpf.3 png.5
	dodoc ANNOUNCE CHANGES KNOWNBUG README TODO Y2KINFO
}

pkg_postinst() {
	# the libpng authors really screwed around between 1.2.1 and 1.2.3
	if [ -f "${ROOT}/usr/$(get_libdir)/libpng.so.3.1.2.1" ] ; then
		rm "${ROOT}/usr/$(get_libdir)/libpng.so.3.1.2.1"
	fi
}
