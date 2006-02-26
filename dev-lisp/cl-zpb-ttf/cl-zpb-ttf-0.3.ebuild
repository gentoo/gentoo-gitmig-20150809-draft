# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-zpb-ttf/cl-zpb-ttf-0.3.ebuild,v 1.1 2006/02/26 20:23:32 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="TrueType font file access library for Common Lisp"
HOMEPAGE="http://www.xach.com/lisp/zpb-ttf/"
SRC_URI="mirror://gentoo/zpb-ttf-${PV}.tgz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

S=${WORKDIR}/zpb-ttf-${PV}

CLPACKAGE=zpb-ttf

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dohtml *.{html,png}
	dodoc LICENSE
}
