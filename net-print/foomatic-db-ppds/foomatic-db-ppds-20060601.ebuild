# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-ppds/foomatic-db-ppds-20060601.ebuild,v 1.1 2006/06/04 14:52:31 genstef Exp $

DESCRIPTION="linuxprinting.org PPD files for postscript printers"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${PN/-ppds}-3.0-${PV}.tar.gz"
# http://linuxprinting.org/download/foomatic

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
S=${WORKDIR}/${P/-ppds}

src_compile() {
	econf || die "econf failed"
	# xml files do not belong to this package
	rm -r db/{oldprinterids,source/{driver,opt,printer}}
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	chmod -R go-w,a-x,a+X ${D}/usr/share/foomatic/db/

	# we do not want multiple ppds
	rm -r ${D}/usr/share/foomatic/db/source/PPD/Kyocera/{de,es,fr,it,pt}
}
