# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-port/cl-port-1.0.1.1.ebuild,v 1.4 2004/07/14 15:59:41 agriffis Exp $

inherit common-lisp

DESCRIPTION="Cross-implementation portability functions taken from the Common Lisp Object Code Collection such as code for sockets, shell functions and paths."
HOMEPAGE="http://www.sourceforge.net/projects/clocc/
	http://packages.debian.org/unstable/devel/cl-port.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-port/${PN}_${PV}.orig.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=port

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc port.html
}
