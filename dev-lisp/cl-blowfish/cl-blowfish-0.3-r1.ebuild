# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-blowfish/cl-blowfish-0.3-r1.ebuild,v 1.1 2004/02/12 09:13:13 mkennedy Exp $

inherit common-lisp

DEB_PV=2

DESCRIPTION="Common Lisp implementation of the Blowfish encryption algorithm."
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-blowfish.html
	http://members.optusnet.com.au/apicard/"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-blowfish/cl-blowfish_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-blowfish/cl-blowfish_0.3-2.diff.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=blowfish

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${PN}_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	do-debian-credits
}
