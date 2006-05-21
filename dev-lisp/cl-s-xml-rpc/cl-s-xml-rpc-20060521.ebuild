# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-s-xml-rpc/cl-s-xml-rpc-20060521.ebuild,v 1.1 2006/05/21 06:42:03 mkennedy Exp $

inherit common-lisp

DESCRIPTION="S-XML-RPC is an implementation of XML-RPC in Common Lisp for both client and server."
HOMEPAGE="http://www.common-lisp.net/project/s-xml-rpc/"
SRC_URI="mirror://gentoo/${P#cl-}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-s-xml
	dev-lisp/cl-s-base64
	dev-lisp/cl-s-sysdeps"

S=${WORKDIR}/${P#cl-}

CLPACKAGE=s-xml-rpc

src_unpack() {
	unpack ${A}
	test -f ${S}/Makefile && rm ${S}/Makefile
}

src_install() {
	dodir /usr/share/common-lisp/source/${CLPACKAGE}
	dodir /usr/share/common-lisp/systems
	cp -R src test ${D}/usr/share/common-lisp/source/${CLPACKAGE}/
	common-lisp-install ${CLPACKAGE}.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/${CLPACKAGE}/${CLPACKAGE}.asd \
		/usr/share/common-lisp/systems/
	dodoc ChangeLog
}
