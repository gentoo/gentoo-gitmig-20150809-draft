# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-5.0.2.ebuild,v 1.2 2006/04/09 03:58:07 halcy0n Exp $

inherit eutils toolchain-funcs multilib

MY_P=${PN}-${PV/_rc/RC}
DESCRIPTION="C++ STL library"
HOMEPAGE="http://stlport.sourceforge.net/"
SRC_URI="mirror://sourceforge/stlport/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch

	sed -i \
		-e 's:OPT += -O2::' \
		-e 's:OPT += -g::' \
		build/Makefiles/gmake/{,lib/,app/}*.mak \
		|| die "sed opts failed"

	if [[ $(gcc-major-version) == "3" ]] ; then
		cat <<- EOF >> stlport/config/stl_gcc.h
		#undef _STLP_NATIVE_INCLUDE_PATH
		#define _STLP_NATIVE_INCLUDE_PATH ../g++-v3
		EOF
	else
		cat <<- EOF >> stlport/config/stl_gcc.h
		#undef _STLP_NATIVE_INCLUDE_PATH
		#define _STLP_NATIVE_INCLUDE_PATH ../g++-v4
		EOF
	fi
}

src_compile() {
	cd "${S}"/build/lib
	./configure \
		--with-boost \
		--with-extra-cxxflags="${CXXFLAGS}" || die "configure failed"
	cd ../..

	emake \
		-C build/lib \
		-f gcc.mak \
		depend all || die "Compile failed"
}

src_install() {
	dodir /usr/$(get_libdir)
	cp -pPR build/lib/obj/*/*/libstlport*.so* "${D}"/usr/$(get_libdir)/ || die "dolib.so failed"

	dodir /usr/include
	cp -R "${S}"/stlport "${D}"/usr/include
	rm -r "${D}"/usr/include/stlport/BC50
	chmod -R a+r "${D}"/usr/include/stlport

	cd "${S}"/etc/
	dodoc ChangeLog* ../README *.txt

	cd "${S}"
	dohtml -r doc/*
}
