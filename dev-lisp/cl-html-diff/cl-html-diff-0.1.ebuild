# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-html-diff/cl-html-diff-0.1.ebuild,v 1.3 2005/04/16 20:15:39 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-HTML-DIFF is a Common Lisp library for generating a human-readable diff of two HTML documents, using HTML."
HOMEPAGE="http://www.cliki.net/CL-HTML-DIFF"
SRC_URI="http://lemonodor.com/code/${PN}_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND="dev-lisp/cl-difflib"

CLPACKAGE=cl-html-diff

S=${WORKDIR}/${PN}_${PV}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc LICENSE.txt
}
