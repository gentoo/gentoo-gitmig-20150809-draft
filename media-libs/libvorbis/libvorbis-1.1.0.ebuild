# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.1.0.ebuild,v 1.7 2004/11/01 10:58:02 kloeri Exp $

IUSE=""

inherit libtool flag-o-matic gcc eutils

DESCRIPTION="the Ogg Vorbis sound file format library"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://downloads.xiph.org/releases/vorbis/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64 ~mips sparc hppa alpha ~ia64 ~ppc ~ppc64 ~ppc-macos"

RDEPEND=">=media-libs/libogg-1.0"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix a gcc crash.  With the new atexit patch to gcc, it
	# seems it does not handle -mno-ieee-fp very well.
	sed -i -e "s:-mno-ieee-fp::g" configure

	# Fixes some strange sed-, libtool- and ranlib-errors on
	# Mac OS X
	if use macos || use ppc-macos; then
		glibtoolize
	else
		elibtoolize
	fi
}

src_compile() {
	# Cannot compile with sse2 support it would seem #36104
	use x86 && [ $(gcc-major-version) -eq 3 ] && append-flags -mno-sse2
	[ "`gcc-version`" == "3.4" ] && replace-flags -Os -O2

	# take out -fomit-frame-pointer from CFLAGS if k6-2
	is-flag -march=k6-3 && filter-flags -fomit-frame-pointer
	is-flag -march=k6-2 && filter-flags -fomit-frame-pointer
	is-flag -march=k6 && filter-flags -fomit-frame-pointer

	# over optimization causes horrible audio artifacts #26463
	filter-flags -march=pentium?

	# gcc on hppa causes issues when assembling
	use hppa && replace-flags -march=2.0 -march=1.0

	# Make prelink work properly
	append-flags -fPIC
	append-ldflags -fPIC

	econf || die
	use macos && cd ${S} && sed -i -e 's/examples//' Makefile
	use ppc-macos && cd ${S} && sed -i -e 's/examples//' Makefile
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	if use macos; then
		dosym /usr/$(get_libdir)/libvorbisfile.3.1.0.dylib /usr/$(get_libdir)/libvorbisfile.0.dylib
		dosym /usr/$(get_libdir)/libvorbisenc.2.0.0.dylib /usr/$(get_libdir)/libvorbisenc.0.dylib
	elif use ppc-macos; then
		dosym /usr/$(get_libdir)/libvorbisfile.3.1.0.dylib /usr/$(get_libdir)/libvorbisfile.0.dylib
		dosym /usr/$(get_libdir)/libvorbisenc.2.0.0.dylib /usr/$(get_libdir)/libvorbisenc.0.dylib
	else
		dosym /usr/$(get_libdir)/libvorbisfile.so.3.1.0 /usr/$(get_libdir)/libvorbisfile.so.0
		dosym /usr/$(get_libdir)/libvorbisenc.so.2.0.0 /usr/$(get_libdir)/libvorbisenc.so.0
	fi

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README todo.txt
	docinto txt
	dodoc doc/*.txt
	dohtml -r doc
}
