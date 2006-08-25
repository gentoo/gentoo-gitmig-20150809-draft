# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-fiveam-darcs/cl-fiveam-darcs-20060825.ebuild,v 1.1 2006/08/25 06:42:45 mkennedy Exp $

EDARCS_REPOSITORY="http://common-lisp.net/project/bese/repos/fiveam/"

inherit eutils multilib darcs common-lisp

DESCRIPTION="FiveAM is a simple regression testing framework designed for Common Lisp."
HOMEPAGE="http://common-lisp.net/project/bese/yaclml.html"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~ppc"
IUSE=""
DEPEND="dev-lisp/cl-arnesi-darcs"

CLPACKAGE=fiveam

src_install() {
	common-lisp-install fiveam.asd
	common-lisp-system-symlink
	insinto ${CLSOURCEROOT}/${CLPACKAGE}/
	doins -r src t
	dodoc README COPYING
}
