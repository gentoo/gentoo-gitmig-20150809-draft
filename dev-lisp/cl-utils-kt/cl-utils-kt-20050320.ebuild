# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-utils-kt/cl-utils-kt-20050320.ebuild,v 1.2 2005/03/22 15:34:16 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A library of Kenny Tilton's favourite Common Lisp utilities."
HOMEPAGE="http://common-lisp.net/project/cells/
	http://www.tilton-technology.com/cells_top.html"
SRC_URI="mirrors://gentoo/utils-kt-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

CLPACKAGE=utils-kt

S=${WORKDIR}/utils-kt

# Note: To update this version, use
# http://common-lisp.net/cgi-bin/viewcvs.cgi/cell-cultures/utils-kt/?cvsroot=cells
# and compare dates.  Then use the "Download tarball" link.

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
}
