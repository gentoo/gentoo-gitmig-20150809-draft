# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.31.0_alpha2.ebuild,v 1.1 2004/02/03 07:55:10 george Exp $

MyPV="2004202"

DESCRIPTION="Boost provides free peer-reviewed portable C++ source libraries."
HOMEPAGE="http://www.boost.org"
#SRC_URI="http://easynews.dl.sourceforge.net/sourceforge/boost/boost-${PV}.tar.bz2"
SRC_URI="mirror://gentoo/${PN}-${MyPV}.tar.bz2"

S=${WORKDIR}/${PN}

LICENSE="freedist"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT="1"
IUSE="icc"

# This would be a good place for someone to figure out how to get
# boost to build nicely with icc, as it's documented to be doable.

DEPEND="virtual/glibc"
RDEPEND=">=dev-util/yacc-1.9.1-r1
	>=dev-lang/python-2.2.1
	icc? ( >=dev-lang/icc-7.1 )"

src_compile() {
	local PYTHON_VERSION=$(/usr/bin/python -V 2>&1 | sed 's/Python \([0-9][0-9]*\.[0-9][0-9]*\)\..*/\1/')
	local BOOST_TOOLSET
	local arch

	if [ "`use icc`" ] ; then
		BOOST_TOOLSET="intel-linux"
	else
		BOOST_TOOLSET="gcc"
	fi

	# Build bjam, a jam variant, which is used instead of make
	cd ${S}/tools/build/jam_src
	./build.sh ${BOOST_TOOLSET} || die "Failed to build bjam"
	cd ${S}

	if [ "${ARCH}" == "amd64" ]; then
		arch=
	else
		arch=${ARCH}
	fi

	if [ "`use icc`" ] ; then
		./tools/build/jam_src/bin.linux${arch}/bjam -j2 \
		-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=${PYTHON_VERSION} \
		-sTOOLS=${BOOST_TOOLSET} \
		-sINTEL_LINUX_VERSION="70" || die "Failed to build boost libraries."
	else
		./tools/build/jam_src/bin.linux${arch}/bjam ${MAKEOPTS} \
		-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=${PYTHON_VERSION} \
		-sTOOLS=${BOOST_TOOLSET}

		einfo "Don't worry if there are a few (probably 6) failures above."
		einfo "Some targets merely need to be combined.  Here goes:"

		./tools/build/jam_src/bin.linux${arch}/bjam \
		-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=${PYTHON_VERSION} \
		-sTOOLS=${BOOST_TOOLSET} || die "Failed to build boost libraries."
	fi
}

src_install () {
	# Unfortunately boost doesn't provide a standard way to
	# install itself.  So it's done "manually" here.

	# install libraries
	find bin/boost/libs -type f -name \*.a -exec dolib.a {} \;
	find bin/boost/libs -type f -name "*.so*" -exec dolib.so {} \;

	# install source/header files

	find boost -type f \
	-exec install -D -m0644 {} ${D}/usr/include/{} \;

	# install build tools
	cd tools/build
	#do_whatever is too limiting here, need to move bunch of different stuff recursively
	dodir /usr/share/${PN}
	cp -a b* c* index.html v1/ v2/ ${D}/usr/share/${PN}
	cd ${S}

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
