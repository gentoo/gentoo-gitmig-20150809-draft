# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-meta/cl-meta-0.1.2-r1.ebuild,v 1.7 2005/05/24 18:48:34 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp implementation of META, a technique for building efficient recursive descent parsers."
HOMEPAGE="http://cclan.sourceforge.net/
	http://www.cliki.net/Meta
	http://packages.debian.org/unstable/devel/cl-meta"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-meta/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=meta

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc Prag-Parse.{html,ps} README
}
