# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-1.3.6.1.ebuild,v 1.1 2002/08/06 08:04:42 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TOra - Toolkit For Oracle"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/${PN}/${PN}-alpha-${PV}.tar.gz"
HOMEPAGE="http://www.globecom.se/tora/"

DEPEND=">=x11-libs/qt-3.0.0
		mysql? ( >=dev-db/mysql-3.23 )
		postgres? ( >=dev-db/postgresql-7.1 )"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

src_compile() {
	local myconf

	use kde		&& myconf="$myconf --with-kde" \
				|| myconf="$myconf --without-kde"	
	use mysql	&& myconf="$myconf" \
				|| myconf="$myconf --without-mysql"	
#	use postgres	&& myconf="$myconf" \
#				|| myconf="$myconf --without-postgres"	
	use oci8	&& myconf="$myconf" \
				|| myconf="$myconf --without-oracle"	

	patch -p0 < ${FILESDIR}/tora-${PV}.patch

	./configure \
		--prefix=/usr \
		--with-mono \
		$myconf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dodir ${D}/usr/bin
	make \
		ROOT=${D} \
		install || die "make install failed"
}
