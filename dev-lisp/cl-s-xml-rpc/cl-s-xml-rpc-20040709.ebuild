# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-s-xml-rpc/cl-s-xml-rpc-20040709.ebuild,v 1.3 2004/07/16 09:27:35 dholm Exp $

inherit common-lisp

DESCRIPTION="S-XML-RPC is an implementation of XML-RPC in Common Lisp for both client and server."
HOMEPAGE="http://www.common-lisp.net/project/s-xml-rpc/"
SRC_URI="mirrors://gentoo/s-xml-rpc-20040709.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/cl-s-xml
	dev-lisp/cl-aserve"

S=${WORKDIR}/${PN#cl-}

CLPACKAGE=s-xml-rpc

src_install() {
	dodir /usr/share/common-lisp/source/s-xml-rpc
	dodir /usr/share/common-lisp/systems
	cp -R src ${D}/usr/share/common-lisp/source/s-xml-rpc/
	common-lisp-install s-xml-rpc.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/s-xml-rpc/s-xml-rpc.asd \
		/usr/share/common-lisp/systems/
}
