# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-acl-compat/cl-acl-compat-1.2.35.20040924.ebuild,v 1.2 2005/02/10 09:18:29 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:6}
CVS_PV=${PV:7:4}.${PV:11:2}.${PV:13}

DESCRIPTION="Compatibility layer for Allegro Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/web/cl-acl-compat.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs.${CVS_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cmucl-source
	virtual/commonlisp
	dev-lisp/cl-puri
	dev-lisp/cl-ppcre"

CLPACKAGE=acl-compat

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs.${CVS_PV}

src_install() {
	dodir /usr/share/common-lisp/source/
	cp -r acl-compat/ ${D}/usr/share/common-lisp/source/
	common-lisp-install acl-compat/acl-compat.asd
	common-lisp-system-symlink
	do-debian-credits
	dodoc ChangeLog
}
