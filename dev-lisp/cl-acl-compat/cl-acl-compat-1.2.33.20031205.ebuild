# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-acl-compat/cl-acl-compat-1.2.33.20031205.ebuild,v 1.1 2004/01/27 20:18:12 mkennedy Exp $

inherit common-lisp

MY_PV=1.2.33
CVS_PV=2003.12.05

DESCRIPTION="Compatibility layer for Allegro Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/web/cl-acl-compat.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs${CVS_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cmucl-source
	virtual/commonlisp"

CLPACKAGE=acl-compat

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs${CVS_PV}

src_install() {
	dodir /usr/share/common-lisp/source/
	cp -r acl-compat/ ${D}/usr/share/common-lisp/source/
	common-lisp-install ${FILESDIR}/acl-compat.asd
	common-lisp-system-symlink
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
