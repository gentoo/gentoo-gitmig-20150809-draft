# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.29.0.ebuild,v 1.5 2003/09/06 22:29:24 msterret Exp $

MY_V="${PV//\./_}"

DESCRIPTION="Boost provides free peer-reviewed portable C++ source libraries."
HOMEPAGE="http://www.boost.org"
SRC_URI="http://boost.sourceforge.net/release/boost_${MY_V}.tar.gz"
LICENSE="freedist"
KEYWORDS="x86 ~ppc"
SLOT="1"
IUSE=""

RDEPEND=">=dev-util/yacc-1.9.1-r1
	>=dev-lang/python-2.2.1"

S="${WORKDIR}/boost_${MY_V}"

src_compile() {
	# first compile jam (the boost build tool)
	cd ${S}/tools/build/jam_src
	emake || die "couldn't build jam"

	# now build boost libraries
	cd ${S}
	./tools/build/jam_src/bin.linux${ARCH}/bjam -j2 \
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
