# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-htmlgen/cl-htmlgen-1.2.27.20030919.ebuild,v 1.3 2003/11/14 11:41:53 seemant Exp $

inherit common-lisp

MY_PV=1.2.27
CVS_PV=2003.09.19

DESCRIPTION="HTML generation library for Common Lisp programs"
HOMEPAGE="http://packages.debian.org/unstable/web/cl-htmlgen.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs${CVS_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=htmlgen

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs${CVS_PV}

src_install() {
	common-lisp-install aserve/htmlgen/*.cl aserve/htmlgen/*.asd
	common-lisp-system-symlink
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
