# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-trivial-http/cl-trivial-http-1.1.ebuild,v 1.1 2005/02/04 08:01:57 mkennedy Exp $

inherit common-lisp

DESCRIPTION="TRIVIAL-HTTP is a library for doing HTTP POST and GET over a socket interface"
HOMEPAGE="http://www.cliki.net/trivial-http"
SRC_URI="http://www.unmutual.info/software/trivial-http-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/cl-trivial-sockets"

S=${WORKDIR}/trivial-http-${PV}

CLPACKAGE=trivial-http

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README LICENSE
}
