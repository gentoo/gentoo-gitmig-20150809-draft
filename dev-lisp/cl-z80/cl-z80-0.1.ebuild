# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-z80/cl-z80-0.1.ebuild,v 1.1 2006/07/30 00:32:15 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Z80 assembler with S-expression based syntax."
HOMEPAGE="http://www.cl-user.net/asp/libs/z80"
SRC_URI="mirror://gentoo/z80-${PV}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=z80

S=${WORKDIR}/z80_${PV}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc README LICENSE
	insinto /usr/share/doc/${PF}/examples
	doins *.l80
}
