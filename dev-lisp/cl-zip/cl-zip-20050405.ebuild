# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-zip/cl-zip-20050405.ebuild,v 1.2 2005/11/01 23:53:31 vapier Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp library for reading and writing .zip files"
HOMEPAGE="http://common-lisp.net/project/zip/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/cl-salza"

S=${WORKDIR}/zip

CLPACKAGE=zip

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dohtml *.html
}
