# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-yaclml/cl-yaclml-0.5.2.ebuild,v 1.2 2005/02/24 05:49:57 mkennedy Exp $

inherit common-lisp

DESCRIPTION="yaclml is a collection of macros and utilities for generating XML/HTML like markup from lisp code"
HOMEPAGE="http://common-lisp.net/project/bese/yaclml.html"
SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/yaclml_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="dev-lisp/cl-iterate
	dev-lisp/cl-arnesi
	doc? ( virtual/tetex )"

CLPACKAGE="yaclml"

S=${WORKDIR}/yaclml_${PV}

src_unpack() {
	unpack ${A}
	find ${S}/ -type d -name .arch-ids -exec rm -rf '{}' \; &>/dev/null
}

src_compile() {
	if use doc; then
		make -C docs || die
	fi
}

src_install() {
	dodir /usr/share/common-lisp/source/yaclml
	dodir /usr/share/common-lisp/systems
	cp -R src ${D}/usr/share/common-lisp/source/yaclml/
	common-lisp-install yaclml.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/yaclml/yaclml.asd \
		/usr/share/common-lisp/systems/
	use doc && dodoc docs/yaclml.pdf
}
