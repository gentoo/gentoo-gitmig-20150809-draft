# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-hello/cl-hello-0.2.ebuild,v 1.2 2005/03/21 07:23:44 mkennedy Exp $

inherit common-lisp

DESCRIPTION="An example of how to layout the file structure of a Lisp program or library."
HOMEPAGE="http://www.cliki.net/hello-lisp"
SRC_URI="http://constantly.at/lisp/hello-lisp-${PV}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=hello-lisp

S=${WORKDIR}/hello-lisp

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README
}
