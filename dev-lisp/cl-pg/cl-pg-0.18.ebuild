# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pg/cl-pg-0.18.ebuild,v 1.5 2005/02/03 00:42:17 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=3

DESCRIPTION="Pg is a socket-level interface to the PostgreSQL object-relational Database for Common Lisp."
HOMEPAGE="http://www.chez.com/emarsden/downloads/ http://www.cliki.net/Pg http://packages.debian.org/unstable/devel/cl-pg.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-pg/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-pg/cl-pg_${PV}-${DEB_PV}.diff.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=pg

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	epatch cl-pg_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install ${FILESDIR}/pg.asd *.lisp
	common-lisp-system-symlink
	do-debian-credits
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
