# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-acl-compat/cl-acl-compat-1.2.27.2003.09.19.ebuild,v 1.5 2004/04/21 16:49:51 vapier Exp $

inherit common-lisp eutils

MY_PV=${PV/.2003/+cvs2003}

DESCRIPTION="Compatibility layer for Allegro Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/web/cl-acl-compat.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}.tar.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cmucl-source
	virtual/commonlisp"

S=${WORKDIR}/cl-portable-aserve-${MY_PV}

CLPACKAGE=acl-compat

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-lw-buffering.lisp-gentoo.patch
}

src_install() {
	dodir /usr/share/common-lisp/source/
	cp -r acl-compat/ ${D}/usr/share/common-lisp/source/
	common-lisp-install ${FILESDIR}/acl-compat.asd
	common-lisp-system-symlink
}

pkg_preinst() {
	rm -rf ${ROOT}/usr/lib/common-lisp/*/${CLPACKAGE}
}

pkg_postrm() {
	rm -rf ${ROOT}/usr/lib/common-lisp/*/${CLPACKAGE}
}
