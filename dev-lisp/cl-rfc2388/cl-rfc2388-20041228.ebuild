# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rfc2388/cl-rfc2388-20041228.ebuild,v 1.1 2004/12/28 21:43:05 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="An implementation of RFC 2388 in Common Lisp"
HOMEPAGE="http://common-lisp.net/project/rfc2388/"
SRC_URI="mirror://gentoo/rfc2388-CVS-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/rfc2388

CLPACKAGE=rfc2388

src_install() {
	common-lisp-install *.lisp ${FILESDIR}/rfc2388.asd
	common-lisp-system-symlink
	dodoc doc/rfc2388.txt
}
