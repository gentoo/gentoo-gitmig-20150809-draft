# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mmdb/mmdb-1.21-r3.ebuild,v 1.4 2010/07/15 20:11:13 maekke Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="The Coordinate Library is designed to assist CCP4 developers in working with coordinate files"
HOMEPAGE="http://www.ebi.ac.uk/~keb/cldoc/"
SRC_URI="http://www.ysbl.york.ac.uk/~emsley/software/${P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="!<sci-libs/ccp4-libs-6.1.3"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-allignment.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# create missing mmdb.pc
	cat >> "${T}"/mmdb.pc <<- EOF
	prefix=${EPREFIX}/usr
	exec_prefix=${EPREFIX}/usr
	libdir=${EPREFIX}/usr/$(get_libdir)
	includedir=${EPREFIX}/usr/include

	Name: ${PN}
	Description: Macromolecular coordinate library
	Version: ${PV}
	Requires:
	Conflicts:
	Libs: -L${EPREFIX}/usr/$(get_libdir) -lmmdb
	Cflags: -I${EPREFIX}/usr/include

	EOF

	insinto /usr/$(get_libdir)/pkgconfig
	doins "${T}"/mmdb.pc || die
}
