# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-who/cl-who-0.4.0-r1.ebuild,v 1.1 2004/02/12 09:13:21 mkennedy Exp $

inherit common-lisp

DESCRIPTION='CL-WHO (is yet another Lisp Markup Language.'
HOMEPAGE="http://weitz.de/cl-who/
	http://www.cliki.net/cl-who"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
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
