# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cdf/cdf-2.7.ebuild,v 1.2 2005/08/20 07:55:57 hansmi Exp $

MY_P="${P/-}"
MY_P="${MY_P/.}"

DESCRIPTION="CDF library and toolkit for storing, manipulating, and accessing multi-dimensional data sets"
HOMEPAGE="http://nssdc.gsfc.nasa.gov/cdf/cdf_home.html"
SRC_URI="ftp://nssdcftp.gsfc.nasa.gov/standards/cdf/dist/${MY_P}/unix/${MY_P}-dist-cdf.tar.gz
	java? ( ftp://nssdcftp.gsfc.nasa.gov/standards/cdf/dist/${MY_P}/unix/${MY_P}-dist-java.tar.gz )"
LICENSE="CDF"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="ncurses java"

RDEPEND="ncurses? ( sys-libs/ncurses )"
DEPEND="${RDEPEND}
		java? ( virtual/jdk
				dev-java/java-config )"

S=${WORKDIR}/${MY_P}-dist

src_compile() {
	local myconf
	if use ncurses; then
		myconf="CURSES=yes"
	else
		myconf="CURSES=no"
	fi
	emake OS=linux ENV=gnu ${myconf} all || die "make failed"
	make test || die "test failed"
	if use java; then
		export CDF_BASE="${S}"
		export CDF_LIB="${S}/src/lib"
		cd cdfjava/jni
		cc -c cdfNativeLibrary.c -I${CDF_BASE}/src/include \
			-I$(java-config -O)/include -I$(java-config -O)/include/linux \
			-o cdfNativeLibrary.o || die "cc failed"
		ld -shared cdfNativeLibrary.o -L${CDF_LIB} -lcdf \
			-o ../lib/libcdfNativeLibrary.so -lc -lm || die "ld failed"
	fi
}

src_install() {
	make INSTALLDIR="${D}/usr" install || die "install failed"
	if use java; then
		cd ${S}/cdfjava
		dolib lib/libcdfNativeLibrary.so
		insinto /usr/share/cdf
		doins */*.jar
	fi
}
