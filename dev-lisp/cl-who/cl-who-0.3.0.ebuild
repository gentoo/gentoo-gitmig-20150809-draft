# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-who/cl-who-0.3.0.ebuild,v 1.1 2003/09/01 19:50:06 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-WHO (where WHO means "with-html-output" for want of a better acronym) is probably just as good or bad as the next one. They are all more or less similar in that they provide convenient means to convert S-expressions intermingled with code into (X)HTML, XML, or whatever but differ with respect to syntax, implementation, and API."
HOMEPAGE="http://weitz.de/cl-who/
	http://www.cliki.net/cl-who"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-who

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink 
	dodoc CHANGELOG INSTALLATION
	dohtml doc/*.html
}
