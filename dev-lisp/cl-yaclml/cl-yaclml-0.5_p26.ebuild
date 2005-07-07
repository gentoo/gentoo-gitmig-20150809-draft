# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-yaclml/cl-yaclml-0.5_p26.ebuild,v 1.3 2005/07/07 22:21:03 mkennedy Exp $

inherit common-lisp

MY_PV=${PV:0:3}
MY_PATCH_PV=${PV:5}

DESCRIPTION="yaclml is a collection of macros and utilities for generating XML/HTML like markup from lisp code"
HOMEPAGE="http://common-lisp.net/project/bese/yaclml.html"
SRC_URI="mirror://gentoo/yaclml--dev--${MY_PV}--patch-${MY_PATCH_PV}.tar.bz2"
# SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/yaclml_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-iterate
	dev-lisp/cl-arnesi"

CLPACKAGE="yaclml"

S=${WORKDIR}/yaclml--dev--${MY_PV}--patch-${MY_PATCH_PV}
# S=${WORKDIR}/yaclml_${PV}

src_unpack() {
	unpack ${A}
	find ${S}/ -type d -name .arch-ids -exec rm -rf '{}' \; &>/dev/null
}

src_install() {
	dodir /usr/share/common-lisp/source/yaclml
	dodir /usr/share/common-lisp/systems
	cp -R src ${D}/usr/share/common-lisp/source/yaclml/
	common-lisp-install yaclml.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/yaclml/yaclml.asd \
		/usr/share/common-lisp/systems/
}
