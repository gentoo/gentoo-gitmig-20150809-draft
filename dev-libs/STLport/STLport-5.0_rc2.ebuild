# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-5.0_rc2.ebuild,v 1.2 2005/08/23 18:00:29 flameeyes Exp $

inherit eutils multilib

MY_P=${PN}-${PV/_rc/RC}
DESCRIPTION="C++ STL library"
HOMEPAGE="http://www.stlport.org/"
SRC_URI="http://www.stlport.org/archive/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/STLport-5.0_rc2-stlp-float-type.patch

	sed -i \
		-e 's:OPT += -O2::' \
		-e 's:OPT += -g::' \
		build/Makefiles/gmake/{,lib/,app/}*.mak \
		|| die "sed opts failed"
	cat <<- EOF >> stlport/config/stl_gcc.h
	#undef _STLP_NATIVE_INCLUDE_PATH
	#define _STLP_NATIVE_INCLUDE_PATH ../g++-v3
	EOF
}

src_compile() {
	export OPT="${CXXFLAGS}"
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
	dodoc ChangeLog* README TODO *.txt

	cd "${S}"
	dohtml -r doc/*
}
