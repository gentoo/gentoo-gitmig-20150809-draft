# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-arnesi/cl-arnesi-1.2_p47.ebuild,v 1.1 2005/02/17 08:47:14 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:3}
MY_PATCH_PV=${PV:5}

DESCRIPTION="ARNESI is a collection of small bits and pieces of Common Lisp code."
HOMEPAGE="http://common-lisp.net/project/bese/arnesi.html"
SRC_URI="mirror://gentoo/arnesi--dev--${MY_PV}--patch-${MY_PATCH_PV}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=arnesi

S=${WORKDIR}/arnesi--dev--${MY_PV}--patch-${MY_PATCH_PV}

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
#	dodoc docs/arnesi.pdf
}
