# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-db-sockets/cl-db-sockets-0.57.1.ebuild,v 1.1 2003/06/10 04:53:04 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Dan Barlow's sockets library for Common Lisp programs."
HOMEPAGE="http://cclan.sourceforge.net
	http://packages.debian.org/unstable/devel/cl-db-sockets.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-db-sockets/${PN}_${PV}.orig.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-rt
	dev-lisp/sbcl"

CLPACKAGE=db-sockets

S=${WORKDIR}/${P}

# TODO: need to port constants-arch.lisp (use SBCL to generate it for
# other implementations)

src_compile() {
	make || die
}

src_install() {
	exeinto /usr/lib/db-sockets
	doexe alien/alien.so
	common-lisp-install array-data.lisp constants.lisp def-to-lisp.lisp \
		defpackage.lisp doc.lisp foreign-glue.lisp inet.lisp malloc.lisp \
		misc.lisp name-service.lisp sockets.lisp sockopt.lisp split.lisp \
		tests.lisp unix.lisp constants-arch.lisp ${FILESDIR}/db-sockets.asd
	common-lisp-system-symlink 
	dohtml *.html
	dodoc INSTALL NEWS README* TODO
}
