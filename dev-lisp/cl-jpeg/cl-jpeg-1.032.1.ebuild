# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-jpeg/cl-jpeg-1.032.1.ebuild,v 1.4 2004/06/24 23:45:24 agriffis Exp $

inherit common-lisp

DESCRIPTION="A JPEG library for Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-jpeg.html
	http://sourceforge.net/projects/cljl"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-jpeg/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-jpeg

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}


pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
