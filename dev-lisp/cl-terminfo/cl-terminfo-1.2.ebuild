# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-terminfo/cl-terminfo-1.2.ebuild,v 1.1 2004/02/15 10:13:22 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp interface to the terminfo database."
HOMEPAGE="http://users.actrix.co.nz/mycroft/cl.html"
SRC_URI="http://common-lisp.net/project/linedit/files/terminfo_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	sys-libs/ncurses"

CLPACKAGE=terminfo

S=${WORKDIR}/terminfo_${PV}

src_install() {
	common-lisp-install *.lisp terminfo.asd
	common-lisp-system-symlink
}
