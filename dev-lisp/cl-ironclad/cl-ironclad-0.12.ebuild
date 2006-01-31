# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ironclad/cl-ironclad-0.12.ebuild,v 1.1 2006/01/31 05:59:01 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Ironclad is a Common Lisp library similar to OpenSSL, GNU TLS or Crypto++"
HOMEPAGE="http://www.cliki.net/Ironclad"
SRC_URI="http://www.cs.rice.edu/~froydnj/lisp/ironclad_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND=""

CLPACKAGE=ironclad

S=${WORKDIR}/ironclad_${PV}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	insinto $CLSOURCEROOT/ironclad/test-vectors
	doins test-vectors/*.lisp
	dodoc README TODO NEWS LICENSE
}
