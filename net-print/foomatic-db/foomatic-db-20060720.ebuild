# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db/foomatic-db-20060720.ebuild,v 1.8 2006/12/01 18:02:04 gustavoz Exp $

DESCRIPTION="Printer information files for foomatic-db-engine to generate ppds"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${PN}-3.0-${PV}.tar.gz
	http://linuxprinting.org/download/foomatic/${PN}-3.0-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="net-print/foomatic-db-engine"

src_compile() {
	econf --disable-gzip-ppds --disable-ppds-to-cups || die "econf failed"
	# ppd files do not belong to this package
	rm -r db/source/PPD
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README TODO USAGE
}
