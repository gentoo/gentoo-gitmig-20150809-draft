# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-osicat/cl-osicat-0.3.3.ebuild,v 1.3 2004/06/24 23:48:48 agriffis Exp $

inherit common-lisp

DESCRIPTION="Osicat is a lightweight operating system interface for Common Lisp on Unix-platforms."
HOMEPAGE="http://www.common-lisp.net/project/osicat/"
SRC_URI="mirror://gentoo/osicat-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=osicat

S=${WORKDIR}/osicat_${PV}

src_install() {
	common-lisp-install *.lisp osicat.asd *.c
	common-lisp-system-symlink
	dodoc README LICENSE
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
