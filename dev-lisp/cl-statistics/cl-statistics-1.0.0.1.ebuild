# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-statistics/cl-statistics-1.0.0.1.ebuild,v 1.1 2003/06/10 04:53:04 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp Statistics Package"
HOMEPAGE="http://www.biolisp.org
	http://packages.debian.org/unstable/devel/cl-statistics.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-statistics/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-statistics

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/${PN}.asd
	common-lisp-system-symlink 
	dodoc *.txt
}
