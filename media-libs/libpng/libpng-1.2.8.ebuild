# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.8.ebuild,v 1.8 2005/04/08 19:22:04 corsair Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/libpng/${P}.tar.bz2"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/1.2.7-gentoo.diff

	[[ $(gcc-version) == "3.3" || $(gcc-version) == "3.2" ]] \
		&& replace-cpu-flags k6 k6-2 k6-3 i586

	local makefilein="scripts/makefile.linux"
	if use ppc-macos ; then
		epatch "${FILESDIR}"/macos.patch # implements strnlen
		makefilein="scripts/makefile.darwin"
	fi
	sed \
		-e "/^ZLIBLIB=/s:=.*:=/usr/$(get_libdir):" \
		-e '/^ZLIBINC=/s:=.*:=/usr/include:' \
		-e "s:-O3:${CFLAGS}:" \
		-e '/^prefix=/s:/local::' \
		-e '/^MANPATH=/s:/man:/share/man:' \
		-e "/^LIBPATH=/s:/lib:/$(get_libdir):" \
		-e 's:mkdir:mkdir -p:' \
		${makefilein} > Makefile
	use ppc-macos || sed -i -e '/^OBJSDLL =/s:=:= -lz -lm :' Makefile
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		|| die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES KNOWNBUG README TODO Y2KINFO
}

pkg_postinst() {
	# the libpng authors really screwed around between 1.2.1 and 1.2.3
	if [[ -f ${ROOT}/usr/$(get_libdir)/libpng.so.3.1.2.1 ]] ; then
		rm -f "${ROOT}"/usr/$(get_libdir)/libpng.so.3.1.2.1
	fi
}
