# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.28.ebuild,v 1.3 2003/07/12 09:22:21 aliz Exp $

DESCRIPTION="Boost provides free peer-review portable C++ source libraries."
MY_V="`echo ${PV} |sed -e 's:\.:_:g'`"
S=${WORKDIR}/boost_${MY_V}
SRC_URI="http://boost.sourceforge.net/release/boost_${MY_V}.tar.gz"
HOMEPAGE="http://www.boost.org"
LICENSE="freedist"
DEPEND=">=dev-util/yacc-1.9.1-r1
	>=dev-lang/python-2.2.1"
KEYWORDS="x86"
SLOT="1"
IUSE=""

src_compile() {

	# first compile jam (the boost build tool)
	cd ${S}/tools/build/jam_src
	emake || die "couldn't build jam"

	# now build boost libraries
	cd ${S}
	./tools/build/jam_src/bin.linuxx86/bjam -j2 \
		-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=2.2 \
		-sTOOLS=gcc || die "build error"
}

src_install () {
	
	# jam does not provide smth like 'make install' :(

	cd ${S}
	# install libraries
	find libs -type f -name \*.a -exec dolib.a {} \; 	
	find libs -type f -name \*.so -exec dolib.so {} \; 	

	# install source/header files
	find boost -type f -exec install -D -m0644 {} ${D}/usr/include/{} \;

	# install documentation
	dodoc README

	# this part should really use dohtml -- karltk
	for i in htm html jpg jpeg gif css
	do
		find . -type f -name "*.${i}" -exec \
			install -D -m0644 {} ${D}/usr/share/doc/${P}/html/{} \;
	done

}

