# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-port/cl-port-1.0.1.2-r2.ebuild,v 1.1 2004/02/12 09:13:14 mkennedy Exp $

inherit common-lisp

DEB_PV=2

DESCRIPTION="Cross-implementation portability functions taken from the Common Lisp Object Code Collection"
HOMEPAGE="http://www.sourceforge.net/projects/clocc/
	http://packages.debian.org/unstable/devel/cl-port.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-port/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-port/cl-port_${PV}-${DEB_PV}.diff.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cmucl-source"

CLPACKAGE=port

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch cl-port_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc port.html
}
