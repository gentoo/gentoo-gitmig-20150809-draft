# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-arnesi-darcs/cl-arnesi-darcs-20060825.ebuild,v 1.2 2006/08/25 05:40:19 mkennedy Exp $

EDARCS_REPOSITORY="http://common-lisp.net/project/bese/repos/arnesi_dev/"

inherit eutils multilib darcs common-lisp

DESCRIPTION="arnesi is a Common Lisp utility suite used with bese projects"
HOMEPAGE="http://common-lisp.net/project/bese/arnesi.html"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=arnesi

src_install() {
	common-lisp-install *.asd
	common-lisp-system-symlink
	insinto ${CLSOURCEROOT}/${CLPACKAGE}
	doins -r src t
}
