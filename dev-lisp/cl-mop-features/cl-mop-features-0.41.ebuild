# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mop-features/cl-mop-features-0.41.ebuild,v 1.1 2006/02/03 18:07:14 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp library which tests for the existence and absence of MOP features."
HOMEPAGE="http://common-lisp.net/project/closer/closer-mop.html"
SRC_URI="ftp://common-lisp.net/pub/project/closer/${P/cl-/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-lw-compat"

CLPACKAGE=mop-feature-tests

S=${WORKDIR}/mop-features

src_install() {
	common-lisp-install *.{asd,lisp}
	common-lisp-system-symlink
	dodoc *.txt
}
