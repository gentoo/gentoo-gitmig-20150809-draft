# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-5.0.1.ebuild,v 1.1 2006/02/08 05:08:28 vapier Exp $

inherit eutils multilib

MY_P=${PN}-${PV/_rc/RC}
DESCRIPTION="C++ STL library"
HOMEPAGE="http://stlport.sourceforge.net/"
SRC_URI="mirror://sourceforge/stlport/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

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
	export OPT=${CXXFLAGS}
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
