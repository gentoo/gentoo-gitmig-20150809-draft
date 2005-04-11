# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-org-davep-cldict/cl-org-davep-cldict-1.1.ebuild,v 1.2 2005/04/11 07:38:27 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="RFC2229 client for Common Lisp and CLIM"
HOMEPAGE="http://www.davep.org/lisp/"
SRC_URI="http://www.davep.org/lisp/${P#cl-}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lisp/cl-org-davep-dict
	dev-lisp/cl-ppcre
	dev-lisp/cl-mcclim"

CLPACKAGE=org-davep-cldict

S=${WORKDIR}/${P#cl-}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}
