# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-statistics/cl-statistics-1.0.0.2-r1.ebuild,v 1.6 2007/02/03 17:49:37 flameeyes Exp $

inherit common-lisp eutils

DEB_PV=1

DESCRIPTION="Common Lisp Statistics Package"
HOMEPAGE="http://www.biolisp.org http://packages.debian.org/unstable/devel/cl-statistics.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/${PN}_${PV}-${DEB_PV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-statistics

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
