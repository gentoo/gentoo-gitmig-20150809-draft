# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-ppds/foomatic-db-ppds-20070508.ebuild,v 1.3 2007/07/12 10:08:01 uberlord Exp $

inherit eutils

DESCRIPTION="linuxprinting.org PPD files for postscript printers"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~calchan/distfiles/${PN/-ppds}-3.0-${PV}.tar.gz
	http://linuxprinting.org/download/foomatic/${PN/-ppds}-3.0-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${P/-ppds}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/Makefile.in-${PV}.patch"
	# scripts do not belong to this package, no translated ppds, no html and text files
	rm -r db/source/PPD/{*.sh,Kyocera/{de,es,fr,it,pt,*.htm,*.txt}}
}

src_compile() {
	econf || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
