# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-periodic-table/cl-periodic-table-1.0.ebuild,v 1.2 2005/03/18 08:04:59 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp representation of the Periodic Table of the Elements"
HOMEPAGE="http://common-lisp.net/project/chemboy/
	http://www.cliki.net/periodic-table"
SRC_URI="mirror://gentoo/periodic-table-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=periodic-table

S=${WORKDIR}/periodic-table-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README
}
