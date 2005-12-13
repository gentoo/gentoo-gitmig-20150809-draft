# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ansi-tests-cvs/cl-ansi-tests-cvs-0.ebuild,v 1.3 2005/12/13 16:15:26 mkennedy Exp $

ECVS_AUTH="pserver"
ECVS_SERVER="cvs.savannah.gnu.org:/sources/gcl"
ECVS_MODULE="gcl/ansi-tests"
ECVS_USER="anonymous"
# ECVS_CVS_OPTIONS="-dP"

inherit common-lisp-common-2 cvs

IUSE=""

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="The ANSI Common Lisp compliance test suite from the GCL CVS tree."
SRC_URI=""
HOMEPAGE="http://www.cliki.net/GCL%20ANSI%20Test%20Suite"

DEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

src_compile() {
	rm -f makefile || die
}

src_install () {
	insinto $CLSOURCEROOT/ansi-tests
	doins *.lsp *.system
	dodoc ISSUES README TODO
}
