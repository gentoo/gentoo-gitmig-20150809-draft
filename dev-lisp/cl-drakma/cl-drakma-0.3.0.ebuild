# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-drakma/cl-drakma-0.3.0.ebuild,v 1.1 2006/09/02 18:19:33 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Drakma is a Common Lisp HTTP client."
HOMEPAGE="http://weitz.de/drakma/"
SRC_URI="mirror://gentoo/${PN/cl-}_${PV}.orig.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"
DEPEND="dev-lisp/cl-chunga
	dev-lisp/cl-puri
	>=dev-lisp/cl-base64-3.3.2
	dev-lisp/cl-trivial-sockets
	dev-lisp/cl-plus-ssl"

S=${WORKDIR}/${P/cl-}

CLPACKAGE=drakma

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc CHANGELOG*
	dohtml doc/index.html
}
