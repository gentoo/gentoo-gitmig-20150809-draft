# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-arnesi/cl-arnesi-1.4.0_p5.ebuild,v 1.1 2005/05/18 20:35:52 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:3}
MY_PATCH_PV=${PV:7}

DESCRIPTION="ARNESI is a collection of small bits and pieces of Common Lisp code."
HOMEPAGE="http://common-lisp.net/project/bese/arnesi.html"
SRC_URI="mirror://gentoo/arnesi--dev--${MY_PV}--patch-${MY_PATCH_PV}.tar.bz2"
# SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/arnesi_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=arnesi

S=${WORKDIR}/arnesi--dev--${MY_PV}--patch-${MY_PATCH_PV}
# S=${WORKDIR}/arnesi_${PV}

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
}
