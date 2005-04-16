# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-osicat/cl-osicat-0.4.0.ebuild,v 1.5 2005/04/16 20:43:06 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Osicat is a lightweight operating system interface for Common Lisp on Unix-platforms."
HOMEPAGE="http://www.common-lisp.net/project/osicat/"
SRC_URI="http://common-lisp.net/project/osicat/files/osicat_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=osicat

S=${WORKDIR}/osicat_${PV}

src_install() {
	common-lisp-install *.lisp osicat.asd *.c version.txt
	common-lisp-system-symlink
	dodoc README LICENSE
}
