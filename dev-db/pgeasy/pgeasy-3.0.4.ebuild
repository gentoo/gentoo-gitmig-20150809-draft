# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgeasy/pgeasy-3.0.4.ebuild,v 1.1 2005/05/09 00:31:41 nakano Exp $

inherit eutils

DESCRIPTION="An easy-to-use C interface to PostgreSQL."
HOMEPAGE="http://gborg.postgresql.org/project/pgeasy/projdisplay.php"
SRC_URI="ftp://gborg.postgresql.org/pub/pgeasy/stable/lib${P}.tar.gz
	http://gborg.postgresql.org/download/pgeasy/stable/lib${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-db/libpq"

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	epatch ${FILESDIR}/Makefile-gentoo.patch || die "epatch failed,"
#}

S=${WORKDIR}/lib${P}

#src_compile() {
#	econf
#	emake
#}

src_install() {
#	dodir /usr/lib
#	dodir /usr/include
#	make POSTGRES_HOME=${D}/usr install || die
	einstall
	dodoc CHANGES README
	dohtml docs/*.html
	cp -r examples ${D}/usr/share/doc/${P}/
}

# Notes: pgeasy won't build static libraries
