# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-quick-arrays/cl-quick-arrays-1.0-r1.ebuild,v 1.1 2004/02/12 09:13:19 mkennedy Exp $

inherit common-lisp

DEB_PV=8

DESCRIPTION="Common Lisp library offering less flexible, but faster arrays"
HOMEPAGE="http://packages.debian.org/unstable/libs/cl-quick-arrays.html
	http://www.cliki.net/quick-arrays"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-quick-arrays/${PN}_${PV}-${DEB_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=quick-arrays

S=${WORKDIR}/quick-arrays-${PV}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	do-debian-credits
}
