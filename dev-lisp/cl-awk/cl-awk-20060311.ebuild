# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-awk/cl-awk-20060311.ebuild,v 1.3 2009/12/15 19:39:12 ssuominen Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp implementation of AWK"
HOMEPAGE="http://www.cliki.net/RegEx-CLAWK-Lexer
	http://www.cl-user.net/asp/libs/tputils"
SRC_URI="mirror://gentoo/clawk-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-regex
	dev-lisp/cl-plus"

S=${WORKDIR}/

CLPACKAGE=clawk

src_unpack() {
	unpack $A
	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_install() {
	common-lisp-install {clawk,packages}.lisp $FILESDIR/clawk.asd
	common-lisp-system-symlink
	docinto examples
	dodoc clawktest.lisp emp.data
}
