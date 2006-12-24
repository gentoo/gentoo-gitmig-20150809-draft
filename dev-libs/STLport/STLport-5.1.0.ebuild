# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-5.1.0.ebuild,v 1.2 2006/12/24 01:03:44 dev-zero Exp $

inherit versionator eutils toolchain-funcs multilib flag-o-matic

KEYWORDS="~amd64 ~x86"

DESCRIPTION="C++ STL library"
HOMEPAGE="http://stlport.sourceforge.net/"
SRC_URI="mirror://sourceforge/stlport/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
IUSE="boost"

DEPEND="boost? ( dev-libs/boost )"
RDEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's/\(OPT += \)-O2/\1/' \
		build/Makefiles/gmake/*cc.mak \
		|| die "sed opts failed"

	sed -i \
		-e 's/_STLP_VENDOR_CSTD::wcsftime/::wcsftime/' \
		stlport/stl/_cwchar.h || die "sed failed"

}

src_compile() {
	cat <<- EOF >> stlport/stl/config/user_config.h
	#define _STLP_NATIVE_INCLUDE_PATH ../g++-v$(gcc-major-version)
	EOF

	sed -i \
		-e "s/\(CC :=\) gcc/\1 $(tc-getCC)/" \
		-e "s/\(CXX :=\) c++/\1 $(tc-getCXX)/" \
		-e "s/^\(CFLAGS = \)/\1 ${CFLAGS} /" \
		-e "s/^\(CCFLAGS = \)/\1 ${CFLAGS} /" \
		build/Makefiles/gmake/gcc.mak || die "sed failed"

	cd "${S}/build/lib"

	local myconf
	use boost && myconf="${myconf} --with-boost=${ROOT}usr/$(get_libdir)"

	append-lfs-flags

	# It's not an autoconf script
	./configure \
		${myconf} \
		--with-extra-cxxflags="${CXXFLAGS}" || die "configure failed"

	cd "${S}"

	cat <<- EOF >> build/Makefiles/config.mak
	CFLAGS := ${CFLAGS}
	EOF

	emake \
		-C build/lib \
		-f gcc.mak \
		depend all || die "Compile failed"
}

src_install() {
	dolib.so build/lib/obj/*/*/libstlport*.so* || die "dolib.so failed"

	insinto /usr/include
	doins -r stlport

	dodoc README etc/ChangeLog* etc/*.txt doc/*
}

src_test() {
	cd "${S}/build"

	sed -i \
		-e "1aLDFLAGS := -L${S}/build/lib/obj/gcc/so -L${S}/build/lib/obj/gcc/so_g -L${S}/build/lib/obj/gcc/so_stlg" \
		test/unit/gcc.mak || die "sed failed"

	emake -C test/unit -f gcc.mak || die "emake tests failed"

	export LD_LIBRARY_PATH="./lib/obj/gcc/so_stlg"
	./test/unit/obj/gcc/so_stlg/stl_unit_test || die "unit tests failed"
}
