# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-gordon/cl-gordon-0.2.ebuild,v 1.1 2006/07/23 21:08:07 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Gordon is a Common Lisp library that can be used to generate flash files."
HOMEPAGE="http://bachue.com/svnwiki/gordon"
SRC_URI="http://www.crazyrobot.net/torta/gordon-${PV}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=gordon

S=${WORKDIR}/gordon

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc ChangeLog COPYING README
}
