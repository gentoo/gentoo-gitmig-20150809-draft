# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-arnesi/cl-arnesi-1.1.0.ebuild,v 1.1 2003/11/30 12:14:22 mkennedy Exp $

inherit common-lisp

DESCRIPTION="arnesi is a collection of small bits and pieces of common lisp code."
HOMEPAGE="http://www.common-lisp.net/project/bese/#arnesi"
SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/arnesi_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
# IUSE="doc"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"
# 	doc? ( app-text/tetex )"

CLPACKAGE=arnesi

S=${WORKDIR}/arnesi_${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-sbcl-toplevel-gentoo.patch
	epatch ${FILESDIR}/${PV}-clisp-specials-gentoo.patch
}

# src_compile() {
# 	if use doc; then
# 		make -C docs
# 	fi
# }

src_install() {
	dodir /usr/share/common-lisp/source/arnesi
	dodir /usr/share/common-lisp/systems
	cp -R src ${D}/usr/share/common-lisp/source/arnesi/
	common-lisp-install arnesi.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/arnesi/arnesi.asd \
		/usr/share/common-lisp/systems/
#	use doc && dodoc docs/arnesi.pdf
	dodoc docs/arnesi.pdf
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
