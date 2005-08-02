# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-who/cl-who-0.6.0.ebuild,v 1.1 2005/08/02 21:56:48 mkennedy Exp $

inherit common-lisp

DESCRIPTION='CL-WHO (is yet another Lisp Markup Language).'
HOMEPAGE="http://weitz.de/cl-who/
	http://www.cliki.net/cl-who"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-who

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc CHANGELOG INSTALLATION
	dohtml doc/*.html
}
