# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pipes/cl-pipes-1.2.1.ebuild,v 1.1 2004/02/12 09:13:14 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp library for pipes or streams"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-pipes.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-pipes/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=pipes

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc COPYING
}
