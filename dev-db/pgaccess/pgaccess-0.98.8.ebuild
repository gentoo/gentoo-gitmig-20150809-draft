# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgaccess/pgaccess-0.98.8.ebuild,v 1.2 2003/03/18 08:23:42 nakano Exp $

DESCRIPTION="a database frontend for postgresql"
HOMEPAGE="http://www.pgaccess.org/"
SRC_URI="http://www.pgaccess.org/download/${P}.tar.gz"
LICENSE="POSTGRESQL"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

# Build-time dependencies
DEPEND=">=dev-lang/tcl-8.3.4
	>=dev-lang/tk-8.3.4
	>=dev-db/postgresql-7.3"

S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch || die
	emake || die
}

src_install() {
	einstall || die
}
