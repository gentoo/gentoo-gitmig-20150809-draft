# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-ansi-tests-cvs/cl-ansi-tests-cvs-0.ebuild,v 1.2 2005/06/17 16:49:29 mkennedy Exp $

ECVS_AUTH="ext"
export CVS_RSH="ssh"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gcl"
ECVS_MODULE="gcl/ansi-tests"
ECVS_BRANCH="HEAD"
ECVS_USER="anoncvs"
#ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"
ECVS_SSH_HOST_KEY="savannah.gnu.org,199.232.41.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="

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
