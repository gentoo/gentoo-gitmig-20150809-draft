# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-flexi-streams/cl-flexi-streams-0.5.8.ebuild,v 1.1 2006/09/02 07:43:45 mkennedy Exp $

inherit common-lisp

DESCRIPTION="FLEXI-STREAMS implements \"virtual\" bivalent streams that can be layered atop real binary or bivalent streams."
HOMEPAGE="http://weitz.de/flexi-streams/
	http://www.cliki.net/flexi-streams"
SRC_URI="mirror://gentoo/${PN/cl-}_${PV}.orig.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-trivial-gray-streams"
SLOT="0"

S=${WORKDIR}/${P/cl-}

CLPACKAGE=flexi-streams

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc CHANGELOG
	dohtml doc/index.html
	insinto /usr/share/doc/${PF}/html
	doins doc/foo.txt
}
