# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-osicat/cl-osicat-0.5.0.ebuild,v 1.2 2005/11/23 16:44:21 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Osicat is a lightweight operating system interface for Common Lisp on Unix-platforms."
HOMEPAGE="http://www.common-lisp.net/project/osicat/"
SRC_URI="http://common-lisp.net/project/osicat/files/osicat_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-uffi"

CLPACKAGE=osicat

S=${WORKDIR}/osicat_${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp osicat.asd *.c version.txt
	common-lisp-system-symlink
	dodoc README LICENSE
}
