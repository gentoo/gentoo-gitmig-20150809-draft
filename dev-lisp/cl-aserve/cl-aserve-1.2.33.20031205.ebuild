# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-aserve/cl-aserve-1.2.33.20031205.ebuild,v 1.1 2004/01/27 20:25:09 mkennedy Exp $

inherit common-lisp

MY_PV=1.2.33
CVS_PV=2003.12.05

DESCRIPTION="A portable version of AllegroServe which is a web application server for Common Lisp programs."
HOMEPAGE="http://packages.debian.org/unstable/web/cl-aserve.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs${CVS_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	cl-acl-compat
	cl-htmlgen"

CLPACKAGE=aserve

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs${CVS_PV}

src_install() {
	common-lisp-install aserve/*.cl aserve/*.asd
	common-lisp-system-symlink

	dodoc ChangeLog README README.cmucl INSTALL.lisp logical-hostnames.lisp
	docinto examples
	dodoc contrib/*.lisp
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
