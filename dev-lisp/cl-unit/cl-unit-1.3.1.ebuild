# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-unit/cl-unit-1.3.1.ebuild,v 1.2 2003/10/17 19:12:26 mkennedy Exp $

inherit common-lisp

DEB_PV=1

DESCRIPTION="A regression suite library for Common Lisp"
HOMEPAGE="http://www.ancar.org/CLUnit/docs/CLUnit.html
	http://packages.debian.org/unstable/devel/cl-unit.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-unit/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-unit/cl-unit_${PV}-${DEB_PV}.diff.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=clunit

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch cl-unit_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/clunit.asd
	common-lisp-system-symlink
	dodoc license readme
	dohtml docs/*
	do-debian-credits
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
