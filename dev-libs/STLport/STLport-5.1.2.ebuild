# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-5.1.2.ebuild,v 1.2 2007/04/02 00:35:54 josejx Exp $

inherit eutils versionator eutils toolchain-funcs multilib flag-o-matic

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

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

	epatch "${FILESDIR}/${P}-wrong_russian_currency_name.patch"

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

	append-lfs-flags

	sed -i \
		-e "s|\(CC :=\) gcc|\1 $(tc-getCC)|" \
		-e "s|\(CXX :=\) c++|\1 $(tc-getCXX)|" \
		-e "s|^\(CFLAGS = \)|\1 ${CFLAGS} |" \
		-e "s|^\(CCFLAGS = \)|\1 ${CFLAGS} |" \
		-e "s|^\(CPPFLAGS = \)|\1 ${CPPFLAGS} |" \
		build/Makefiles/gmake/gcc.mak || die "sed failed"

	local myconf
	if use boost ; then
		myconf="${myconf} --with-boost=/usr/include"
		sed -i \
			-e 'N;N;N;s:/\**\n\(#define _STLP_USE_BOOST_SUPPORT 1\)*\n\*/:\1:' \
			stlport/stl/config/user_config.h
	fi

	cd "${S}/build/lib"

	# It's not an autoconf script
	./configure \
		${myconf} \
		--with-extra-cxxflags="${CXXFLAGS}" || die "configure failed"

	cd "${S}"

	cat <<- EOF >> build/Makefiles/config.mak
	CFLAGS := ${CFLAGS}
	EOF

	local targets
	targets="all-shared all-static"

	# The build-system is broken in respect to parallel builds, bug #161881
	emake \
		-j1 \
		-C build/lib \
		-f gcc.mak \
		depend ${targets} || die "Compile failed"

}

src_install() {
	emake -C build/lib -f gcc.mak install
	dolib.so lib/*

	emake -C build/lib -f gcc.mak install-static
	dolib.a lib/*.a

	insinto /usr/include
	doins -r stlport

	dodoc README etc/ChangeLog* etc/*.txt doc/*
}

src_test() {
	cd "${S}/build"

	sed -i \
		-e "1aLDFLAGS := -L${S}/build/lib/obj/gcc/so -L${S}/build/lib/obj/gcc/so_g -L${S}/build/lib/obj/gcc/so_stlg" \
		test/unit/gcc.mak || die "sed failed"

	emake -j1 -C test/unit -f gcc.mak || die "emake tests failed"

	export LD_LIBRARY_PATH="./lib/obj/gcc/so_stlg"
	./test/unit/obj/gcc/so_stlg/stl_unit_test || die "unit tests failed"
}
