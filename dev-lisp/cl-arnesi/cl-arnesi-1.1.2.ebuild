# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-arnesi/cl-arnesi-1.1.2.ebuild,v 1.1 2004/02/15 03:46:21 mkennedy Exp $

inherit common-lisp

DESCRIPTION="arnesi is a collection of small bits and pieces of common lisp code."
HOMEPAGE="http://www.common-lisp.net/project/bese/#arnesi"
SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/arnesi/arnesi_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=arnesi

S=${WORKDIR}/arnesi_${PV}

src_unpack() {
	unpack ${A}
	find ${S}/ -type d -name .arch-ids -exec rm -rf '{}' \; &>/dev/null
}

src_install() {
	dodir /usr/share/common-lisp/source/arnesi
	dodir /usr/share/common-lisp/systems
	cp -R src ${D}/usr/share/common-lisp/source/arnesi/
	common-lisp-install arnesi.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/arnesi/arnesi.asd \
		/usr/share/common-lisp/systems/
	dodoc docs/arnesi.pdf
}
