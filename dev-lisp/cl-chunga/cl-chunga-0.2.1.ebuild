# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-chunga/cl-chunga-0.2.1.ebuild,v 1.1 2006/11/09 04:25:40 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Portable chunked streams for Common Lisp"
HOMEPAGE="http://weitz.de/chunga/"
SRC_URI="http://common-lisp.net/project/portage-overlay/distfiles/${PN/cl-}_${PV}.orig.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-flexi-streams"
SLOT="0"

S=${WORKDIR}/${P/cl-}

CLPACKAGE=chunga

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc CHANGELOG*
	dohtml doc/index.html
}
