# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-utilities/cl-utilities-1.0.2.ebuild,v 1.1 2005/05/24 18:48:36 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp library of semi-standard utilities."
HOMEPAGE="http://common-lisp.net/project/cl-utilities/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-split-sequence"

CLPACKAGE=cl-utilities

src_install() {
	common-lisp-install cl-utilities.asd *.lisp
	common-lisp-system-symlink
	dodoc README
}
