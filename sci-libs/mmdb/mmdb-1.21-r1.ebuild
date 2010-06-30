# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mmdb/mmdb-1.21-r1.ebuild,v 1.1 2010/06/30 20:55:04 jlec Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="The Coordinate Library is designed to assist CCP4 developers in working with coordinate files"
HOMEPAGE="http://www.ebi.ac.uk/~keb/cldoc/"
SRC_URI="http://www.ysbl.york.ac.uk/~emsley/software/${P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
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
	cat >> ${T}/mmdb.pc <<- EOF
	prefix="${EPREFIX}"
	exec_prefix=\$prefix
	libdir=\$prefix/$(get_libdir)
	includedir=\$prefix/include

	Name: ${PN}
	Description: Macromolecular coordinate library
	Version: ${PV}
	Requires:
	Conflicts:
	Libs: -L\${libdir} -lmmdb
	Cflags: -I\${includedir}

	EOF

	insinto /usr/$(get_libdir)/pkgconfig
	doins ${T}/mmdb.pc || die
}
