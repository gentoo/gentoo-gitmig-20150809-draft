# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pg/cl-pg-20050202.ebuild,v 1.1 2005/02/03 00:42:17 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A socket-level interface to the PostgreSQL ORDMS for Common Lisp"
HOMEPAGE="http://common-lisp.net/project/pg/
	http://www.cliki.net/Pg
	http://packages.debian.org/unstable/devel/cl-pg.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=pg

S=${WORKDIR}/pg

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README NEWS CREDITS TODO
}
