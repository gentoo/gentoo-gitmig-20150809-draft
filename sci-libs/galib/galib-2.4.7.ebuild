# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/galib/galib-2.4.7.ebuild,v 1.1 2008/07/07 10:36:21 bicatali Exp $

inherit multilib

DESCRIPTION="C++ genetic algorithms library "

MYPV="${PV//\./}"

HOMEPAGE="http://lancet.mit.edu/ga/"
SRC_URI="http://lancet.mit.edu/ga/dist/galib${MYPV}.tgz"
LICENSE="GAlib"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"
DEPEND=""

S="${WORKDIR}/galib${MYPV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:/include:/usr/include:' \
		-e "s:/lib:/usr/$(get_libdir):" \
		-e '/^CXX/d' \
		-e '/^CXXFLAGS/d' \
		-e '/^LD/d' \
		makevars || die "sed makevars failed"
}

src_compile() {
	emake lib || die "emake failed"
}

src_install() {
	dodir /usr/$(get_libdir)
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc RELEASE-NOTES README
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc || die "doc install failed"
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		cd examples
		make clean
		sed -i \
			-e '/^include/d' \
			-e '/^INC_DIRS/d' \
			-e '/^LIB_DIRS/d' \
			makefile || die "sed makefile failed"
		doins -r * || die "examples install failed"
	fi
}
