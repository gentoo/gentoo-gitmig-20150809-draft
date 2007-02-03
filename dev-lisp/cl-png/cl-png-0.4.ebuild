# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-png/cl-png-0.4.ebuild,v 1.8 2007/02/03 17:39:54 flameeyes Exp $

inherit common-lisp

DESCRIPTION="Common Lisp package to read and write PNG image files"
HOMEPAGE="http://www.pvv.ntnu.no/~musum/lisp/code/
	http://www.cliki.net/PNG
	http://packages.debian.org/unstable/devel/cl-png.html"
SRC_URI="mirror://debian/pool/main/c/cl-png/cl-png_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=png

src_install() {
	common-lisp-install *.cl *.asd
	common-lisp-system-symlink
	dodoc COPYING README
}
