# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db/foomatic-db-20060601.ebuild,v 1.3 2006/07/15 03:17:21 vapier Exp $

DESCRIPTION="Printer information files for foomatic-db-engine to generate ppds"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${PN}-3.0-${PV}.tar.gz"
# http://linuxprinting.org/download/foomatic

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="net-print/foomatic-db-engine"

src_compile() {
	econf --disable-gzip-ppds --disable-ppds-to-cups || die "econf failed"
	# ppd files do not belong to this package
	rm -r db/source/PPD
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	chmod -R go-w,a-x,a+X ${D}/usr/share/foomatic/db/

	dodoc ChangeLog README TODO USAGE
}
