# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rfc2388-darcs/cl-rfc2388-darcs-20060825.ebuild,v 1.1 2006/08/25 06:33:20 mkennedy Exp $

EDARCS_REPOSITORY="http://common-lisp.net/project/ucw/repos/rfc2388"

inherit eutils multilib darcs common-lisp

DESCRIPTION="An implementation of RFC2388 (cookies) for Common Lisp"
HOMEPAGE="http://common-lisp.net/project/ucw/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~ppc"
IUSE=""
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=rfc2388

src_install() {
	common-lisp-install rfc2388.asd
	common-lisp-system-symlink
	insinto ${CLSOURCEROOT}/${CLPACKAGE}/
	doins -r source test
	dodoc rfc/*.txt
}
