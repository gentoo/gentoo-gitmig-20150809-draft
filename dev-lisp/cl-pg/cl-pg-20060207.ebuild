# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pg/cl-pg-20060207.ebuild,v 1.1 2006/05/01 20:43:46 mkennedy Exp $

inherit common-lisp multilib

DESCRIPTION="A socket-level interface to the PostgreSQL ORDMS for Common Lisp"
HOMEPAGE="http://common-lisp.net/project/pg/
	http://www.cliki.net/Pg
	http://packages.debian.org/unstable/devel/cl-pg.html"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	sys-libs/glibc"				# /usr/lib/libcrypt.so

CLPACKAGE=pg

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${A}
	sed -i 's,/usr/lib,'"/usr/$(get_libdir),g" ${S}/pg.asd ${S}/sysdep.lisp
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc README NEWS CREDITS TODO ChangeLog
}
