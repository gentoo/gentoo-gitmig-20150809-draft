# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-statistics/cl-statistics-1.0.0.2-r1.ebuild,v 1.1 2004/02/12 09:13:20 mkennedy Exp $

inherit common-lisp

DEB_PV=1

DESCRIPTION="Common Lisp Statistics Package"
HOMEPAGE="http://www.biolisp.org
	http://packages.debian.org/unstable/devel/cl-statistics.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-statistics/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-statistics/${PN}_${PV}-${DEB_PV}.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-statistics

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/${PN}.asd
	common-lisp-system-symlink
	dodoc *.txt
	do-debian-credits
}
