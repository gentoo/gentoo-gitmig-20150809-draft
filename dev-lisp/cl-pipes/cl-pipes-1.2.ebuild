# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pipes/cl-pipes-1.2.ebuild,v 1.5 2004/07/14 15:58:51 agriffis Exp $

inherit common-lisp

DESCRIPTION="Common Lisp library for pipes or streams"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-pipes.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-pipes/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=pipes

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc COPYING
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
