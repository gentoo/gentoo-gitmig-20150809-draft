# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-statistics/cl-statistics-1.0.0.1.ebuild,v 1.4 2004/07/14 16:16:40 agriffis Exp $

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

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/${PN}.asd
	common-lisp-system-symlink
	dodoc *.txt
}
