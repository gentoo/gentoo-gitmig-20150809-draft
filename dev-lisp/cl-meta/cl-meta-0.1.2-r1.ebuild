# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-meta/cl-meta-0.1.2-r1.ebuild,v 1.3 2004/07/14 15:56:34 agriffis Exp $

inherit common-lisp

DESCRIPTION="A Commoon Lisp implementation of META, a technique for building efficient recursive descent parsers."
HOMEPAGE="http://cclan.sourceforge.net/
	http://www.cliki.net/Meta
	http://packages.debian.org/unstable/devel/cl-meta"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-meta/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=meta

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc Prag-Parse.{html,ps} README
}
