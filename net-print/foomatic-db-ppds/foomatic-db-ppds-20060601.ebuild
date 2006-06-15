# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-ppds/foomatic-db-ppds-20060601.ebuild,v 1.3 2006/06/15 05:33:54 vapier Exp $

DESCRIPTION="linuxprinting.org PPD files for postscript printers"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${PN/-ppds}-3.0-${PV}.tar.gz"
# http://linuxprinting.org/download/foomatic

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${P/-ppds}

src_compile() {
	econf || die "econf failed"
	# xml files do not belong to this package, no translated ppds
	rm -r db/{oldprinterids,source/{driver,opt,printer,PPD/Kyocera/{de,es,fr,it,pt}}}
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	chmod -R go-w,a-x,a+X "${D}"/usr/share/foomatic/db/
}
