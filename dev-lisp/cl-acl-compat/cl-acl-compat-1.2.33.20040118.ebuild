# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-acl-compat/cl-acl-compat-1.2.33.20040118.ebuild,v 1.1 2004/02/12 09:13:12 mkennedy Exp $

inherit common-lisp

MY_PV=${PV:0:6}
CVS_PV=${PV:7:4}.${PV:11:2}.${PV:13:2}

DESCRIPTION="Compatibility layer for Allegro Common Lisp"
HOMEPAGE="http://packages.debian.org/unstable/web/cl-acl-compat.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-portable-aserve/cl-portable-aserve_${MY_PV}+cvs${CVS_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cmucl-source
	virtual/commonlisp"

CLPACKAGE=acl-compat

S=${WORKDIR}/cl-portable-aserve-${MY_PV}+cvs${CVS_PV}

src_install() {
	dodir /usr/share/common-lisp/source/
	cp -r acl-compat/ ${D}/usr/share/common-lisp/source/
	common-lisp-install acl-compat/acl-compat.asd
	# with the last set of common-lisp-controller changes, this is no
	# longer necessary
#	common-lisp-install ${FILESDIR}/acl-compat.asd
	common-lisp-system-symlink
	do-debian-credits
	dodoc ChangeLog
}
