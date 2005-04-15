# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-chemical-compounds/cl-chemical-compounds-1.0.2.ebuild,v 1.2 2005/04/15 19:12:57 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp library for parsing and performing calculations on chemical compound expressions"
HOMEPAGE="http://common-lisp.net/project/chemboy/
	http://www.cliki.net/chemical-compounds"
SRC_URI="mirror://gentoo/chemical-compounds-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="dev-lisp/cl-periodic-table"

CLPACKAGE=chemical-compounds

S=${WORKDIR}/chemical-compounds-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README
}
