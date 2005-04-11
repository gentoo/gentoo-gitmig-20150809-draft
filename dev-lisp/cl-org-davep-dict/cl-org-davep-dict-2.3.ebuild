# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-org-davep-dict/cl-org-davep-dict-2.3.ebuild,v 1.3 2005/04/11 07:35:06 mkennedy Exp $

inherit common-lisp

DESCRIPTION="An RFC2229 client library for Common Lisp"
HOMEPAGE="http://www.davep.org/lisp/"
SRC_URI="http://www.davep.org/lisp/${P#cl-}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/cl-acl-compat
	dev-lisp/cl-split-sequence"

CLPACKAGE=org-davep-dict

S=${WORKDIR}/${P#cl-}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}
