# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.30.0.ebuild,v 1.1 2003/05/17 05:50:03 george Exp $

MY_V="${PV//\./_}"

DESCRIPTION="Boost provides free peer-reviewed portable C++ source libraries."
HOMEPAGE="http://www.boost.org"
#SRC_URI="http://easynews.dl.sourceforge.net/sourceforge/boost/boost_${MY_V}.tar.bz2"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_V}.tar.bz2"

LICENSE="freedist"
KEYWORDS="~x86 ~ppc"
SLOT="1"
IUSE="icc"

# This would be a good place for someone to figure out how to get
# boost to build nicely with icc, as it's documented to be doable.

DEPEND="virtual/glibc"
RDEPEND=">=dev-util/yacc-1.9.1-r1
	>=dev-lang/python-2.2.1
	icc? ( >=dev-lang/icc-7.1 )"

S="${WORKDIR}/boost_${MY_V}"

src_compile() {
	local PYTHON_VERSION=$(/usr/bin/python -V 2>&1 | /usr/bin/cut -d . -f 2,3)
	local BOOST_TOOLSET

	if [ "`use icc`" ] ; then
		BOOST_TOOLSET="intel-linux"
	else
		BOOST_TOOLSET="gcc"
	fi

	# Build bjam, a jam variant, which is used instead of make
	cd ${S}/tools/build/jam_src
	./build.sh ${BOOST_TOOLSET} || die "Failed to build bjam"
	cd ${S}

	if [ "`use icc`" ] ; then
		./tools/build/jam_src/bin.linux${ARCH}/bjam -j2 \
		-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=${PYTHON_VERSION} \
		-sTOOLS=${BOOST_TOOLSET} \
		-sINTEL_LINUX_VERSION="70" || die "Failed to build boost libraries."
	else
		./tools/build/jam_src/bin.linux${ARCH}/bjam -j6 \
		-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=${PYTHON_VERSION} \
		-sTOOLS=${BOOST_TOOLSET}

		einfo "Don't worry if there are a few (probably 6) failures above."
		einfo "Some targets merely need to be combined.  Here goes:"

		./tools/build/jam_src/bin.linux${ARCH}/bjam \
		-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=${PYTHON_VERSION} \
		-sTOOLS=${BOOST_TOOLSET} || die "Failed to build boost libraries."
	fi
}

src_install () {
	# Unfortunately boost doesn't provide a standard way to
	# install itself.  So it's done "manually" here.

	cd ${S}

	# install libraries
	find libs -type f -name \*.a -exec dolib.a {} \;
	find libs -type f -name \*.so -exec dolib.so {} \;

	# install source/header files

	find boost -type f \
	-exec install -D -m0644 {} ${D}/usr/include/{} \;

	# install documentation
	dodoc README
	dohtml index.htm google_logo_40wht.gif c++boost.gif boost.css
	dohtml -A pdf -r more
	dohtml -r people
	dohtml -r doc

	find libs -type f -not -regex '^libs/[^/]*/build/.*' \
		-and -not -regex '^libs/.*/test[^/]?/.*' \
		-and -not -regex '^libs/.*/bench[^/]?/.*' \
		-and -not -regex '^libs/[^/]*/tools/.*' \
		-and -not -name \*.bat \
		-and -not -name Jamfile\* \
		-and -not -regex '^libs/[^/]*/src/.*' \
		-and -not -iname makefile \
		-and -not -name \*.mak \
		-and -not -name .\* \
		-and -not -name \*.dsw \
		-and -not -name \*.dsp \
		-exec \
	install -D -m0644 \{\} ${D}/usr/share/doc/${P}/html/\{\} \;
}
