# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-unit/cl-unit-1.3.ebuild,v 1.4 2004/07/14 16:18:20 agriffis Exp $

inherit common-lisp

DESCRIPTION="A regression suite library for Common Lisp"
HOMEPAGE="http://www.ancar.org/CLUnit/docs/CLUnit.html
	http://packages.debian.org/unstable/devel/cl-unit.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-unit/${PN}_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=clunit

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/clunit.asd
	common-lisp-system-symlink
	dodoc license readme
	dohtml docs/*
}
