# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pg/cl-pg-0.19.ebuild,v 1.1 2004/02/12 09:13:14 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A socket-level interface to the PostgreSQL object-relational Database for Common Lisp"
HOMEPAGE="http://www.chez.com/emarsden/downloads/
	http://www.cliki.net/Pg
	http://packages.debian.org/unstable/devel/cl-pg.html"
SRC_URI="http://www.chez.com/emarsden/downloads/pg-dot-lisp-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=pg

S=${WORKDIR}/pg-${PV}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README NEWS
}
