# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-anaphora/cl-anaphora-0.9.1.ebuild,v 1.2 2004/06/24 23:40:23 agriffis Exp $

inherit common-lisp

DESCRIPTION="Anaphoric macro collection for Common Lisp"
HOMEPAGE="http://www.common-lisp.net/project/anaphora/"
SRC_URI="http://common-lisp.net/project/anaphora/files/anaphora-${PV}.tar.gz"
LICENSE="public-domain"
KEYWORDS="~x86"
SLOT="0"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=anaphora

S=${WORKDIR}/anaphora-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}
