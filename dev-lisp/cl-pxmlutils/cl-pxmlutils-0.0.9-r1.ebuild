# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pxmlutils/cl-pxmlutils-0.0.9-r1.ebuild,v 1.1 2004/02/12 09:13:15 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Portable version of Franz's xmlutils."
HOMEPAGE="http://www.common-lisp.net/project/bese/pxmlutils.html"
SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/pxmlutils/pxmlutils_${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-acl-compat
	virtual/commonlisp"

S=${WORKDIR}/pxmlutils_${PV}

CLPACKAGE=pxmlutils

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-allegro-declare-gentoo.patch
}

src_install() {
	common-lisp-install pxmlutils.asd *.cl
	common-lisp-system-symlink
	dodoc ChangeLog README *.{htm,txt}
}
