# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raul/raul-0.8.0.ebuild,v 1.2 2011/12/18 19:23:42 ago Exp $

EAPI=2

inherit toolchain-funcs multilib eutils

DESCRIPTION="C++ utility library primarily aimed at audio/musical applications."
HOMEPAGE="http://wiki.drobilla.net/Raul"
SRC_URI="http://download.drobilla.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc test"

RDEPEND="dev-libs/boost
	>=dev-libs/glib-2.14.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

RAUL_TESTS="atomic_test atom_test list_test midi_ringbuffer_test path_test quantize_test queue_test ringbuffer_test smf_test table_test thread_test time_test"

src_prepare() {
	epatch "${FILESDIR}/ldconfig2.patch"
}

src_configure() {
	tc-export CC CXX CPP AR RANLIB
	./waf configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--htmldir=/usr/share/doc/${PF}/html \
		$(use debug && echo "--debug") \
		$(use doc && echo "--docs") \
		$(use test && echo "--test") \
		|| die
}

src_compile() {
	./waf || die
}

src_test() {
	cd "${S}/build/test" || die
	for i in ${RAUL_TESTS} ; do
		einfo "Running test ${i}"
		LD_LIBRARY_PATH=.. ./${i} || die
	done
}

src_install() {
	./waf install --destdir="${D}" || die
	dodoc AUTHORS README ChangeLog || die
}
