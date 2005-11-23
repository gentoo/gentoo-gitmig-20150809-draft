# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sasl/cl-sasl-0.2.ebuild,v 1.1 2005/11/23 17:55:55 mkennedy Exp $

inherit common-lisp

DESCRIPTION="SASL client implementation for Common Lisp"
HOMEPAGE="http://www.dtek.chalmers.se/~henoch/text/cl-sasl.html
	http://www.cliki.net/cl-sasl"
SRC_URI="http://www.dtek.chalmers.se/~henoch/text/${PN}/${PN}_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-ironclad"

CLPACKAGE=cl-sasl

S=${WORKDIR}/${PN}_${PV}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc README LICENCE
}
