# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgaccess/pgaccess-0.98.8.ebuild,v 1.14 2008/05/21 15:56:32 dev-zero Exp $

DESCRIPTION="a database frontend for postgresql"
HOMEPAGE="http://www.pgaccess.org/"
SRC_URI="http://www.pgaccess.org/download/${P}.tar.gz"
LICENSE="POSTGRESQL"

SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

# Build-time dependencies
DEPEND=">=dev-lang/tcl-8.3.4
	>=dev-lang/tk-8.3.4
	>=virtual/postgresql-server-7.3"

src_compile() {
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch || die
}

src_install() {
	make prefix=${D} install || die
}

pkg_postinst() {
	einfo "When running the program, if you encount the error "
	einfo "\"Error: Shared library file: '/usr/lib/libpgtcl.so' does not exist.\","
	einfo "you need to emerge postgresql with USE='tcltk' again"
}
