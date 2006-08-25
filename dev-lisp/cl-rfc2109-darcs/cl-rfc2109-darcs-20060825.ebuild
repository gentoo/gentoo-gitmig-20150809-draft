# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rfc2109-darcs/cl-rfc2109-darcs-20060825.ebuild,v 1.1 2006/08/25 06:41:05 mkennedy Exp $

EDARCS_REPOSITORY="http://www.common-lisp.net/project/rfc2109/rfc2109/"

inherit eutils multilib darcs common-lisp

DESCRIPTION="An implementation of RFC2109 for Common Lisp"
HOMEPAGE="http://www.cliki.net/rfc2109"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~ppc"
IUSE=""
DEPEND="dev-lisp/cl-split-sequence"

CLPACKAGE=rfc2109

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc CHANGELOG
}
