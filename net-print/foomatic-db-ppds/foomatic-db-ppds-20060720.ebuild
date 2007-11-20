# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-ppds/foomatic-db-ppds-20060720.ebuild,v 1.13 2007/11/20 03:29:15 kumba Exp $

DESCRIPTION="linuxprinting.org PPD files for postscript printers"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${PN/-ppds}-3.0-${PV}.tar.gz
	http://linuxprinting.org/download/foomatic/${PN/-ppds}-3.0-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${P/-ppds}

src_compile() {
	econf || die "econf failed"
	# xml files do not belong to this package, no translated ppds
	rm -r db/{oldprinterids,source/{driver,opt,printer,PPD/Kyocera/{de,es,fr,it,pt}}}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
