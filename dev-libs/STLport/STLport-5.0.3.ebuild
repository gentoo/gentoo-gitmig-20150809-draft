# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-5.0.3.ebuild,v 1.4 2007/02/14 18:55:15 dev-zero Exp $

inherit eutils versionator eutils toolchain-funcs multilib flag-o-matic

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"

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

	epatch "${FILESDIR}/${PN}-5.0.2-gcc41.patch"
	epatch "${FILESDIR}/${P}-ppc.patch"
	epatch "${FILESDIR}/${P}-sparc.patch"
	epatch "${FILESDIR}/${PN}-5.1.0-wrong_russian_currency_name.patch"

	sed -i \
		-e 's/\(OPT += \)-O2/\1/' \
		build/Makefiles/gmake/*cc.mak \
		|| die "sed opts failed"

	sed -i \
		-e 's/_STLP_VENDOR_CSTD::wcsftime/::wcsftime/' \
		stlport/stl/_cwchar.h || die "sed failed"

}

src_compile() {
	cat <<- EOF >> stlport/stl_user_config.h
	#define _STLP_NATIVE_INCLUDE_PATH ../g++-v$(gcc-major-version)
	EOF

	sed -i \
		-e "s|\(CC :=\) gcc|\1 $(tc-getCC)|" \
		-e "s|\(CXX :=\) c++|\1 $(tc-getCXX)|" \
		-e "s|^\(CFLAGS = \)|\1 ${CFLAGS} |" \
		-e "s|^\(CCFLAGS = \)|\1 ${CFLAGS} |" \
		build/Makefiles/gmake/gcc.mak || die "sed failed"

	local myconf
	if use boost ; then
		myconf="${myconf} --with-boost=${ROOT}usr/include"
		sed -i \
			-e 'N;N;N;s:/\**\n\(#define _STLP_USE_BOOST_SUPPORT 1\)*\n\*/:\1:' \
			stlport/stl_user_config.h
	fi

	cd "${S}/build/lib"

	append-lfs-flags

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
		-e "1aLDFLAGS := -L${S}/build/lib/obj/gcc/shared -L${S}/build/lib/obj/gcc/shared-g -L${S}/build/lib/obj/gcc/shared-stlg" \
		test/unit/gcc.mak || die "sed failed"

	emake -j1 -C test/unit -f gcc.mak || die "emake tests failed"

	export LD_LIBRARY_PATH="./lib/obj/gcc/shared-stlg"
	./test/unit/obj/gcc/shared-stlg/stl_unit_test || die "unit tests failed"
}
