# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-arnesi/cl-arnesi-1.3.ebuild,v 1.2 2005/03/18 07:34:21 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:3}
MY_PATCH_PV=${PV:5}

DESCRIPTION="ARNESI is a collection of small bits and pieces of Common Lisp code."
HOMEPAGE="http://common-lisp.net/project/bese/arnesi.html"
SRC_URI="mirror://gentoo/arnesi--dev--${MY_PV}--base-0.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=arnesi

S=${WORKDIR}/arnesi--dev--${MY_PV}--base-0

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
