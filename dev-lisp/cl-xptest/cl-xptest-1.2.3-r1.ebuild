# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xptest/cl-xptest-1.2.3-r1.ebuild,v 1.1 2004/02/12 09:13:21 mkennedy Exp $

inherit common-lisp

DESCRIPTION="XPTEST is a toolkit for building test suites in Common Lisp"
HOMEPAGE="http://alpha.onshored.com/lisp-software/
	http://www.cliki.net/xptest"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-xptest/cl-xptest_${PV}.orig.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=xptest

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc COPYING README
}
