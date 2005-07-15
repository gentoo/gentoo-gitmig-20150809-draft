# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-isbn/cl-isbn-0.1.ebuild,v 1.1 2005/07/15 15:14:07 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="A Common Lisp library for parsing, validating and hyphenating ISBNs"
HOMEPAGE="http://www.ljosa.com/~ljosa/software/cl-isbn/"
SRC_URI="http://www.ljosa.com/~ljosa/software/cl-isbn/download/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/cl-iterate
	dev-lisp/cl-xlunit"

CLPACKAGE=isbn

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc license.txt
	dohtml doc/index.html
}
