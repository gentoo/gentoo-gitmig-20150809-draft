# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-tbnl/cl-tbnl-0.2.12.ebuild,v 1.1 2004/10/18 15:45:24 mkennedy Exp $

inherit common-lisp

DESCRIPTION="TBNL is a toolkit for building dynamic websites with Common Lisp based on Marc Battyani's mod_lisp apache module."
HOMEPAGE="http://www.weitz.de/tbnl/"
SRC_URI="mirror://gentoo/tbnl-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/cl-kmrcl
	dev-lisp/cl-md5
	dev-lisp/cl-base64
	dev-lisp/cl-url-rewrite"
RDEPEND="${DEPEND}
	www-apache/mod_lisp"

S=${WORKDIR}/tbnl-${PV}

CLPACKAGE=tbnl

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc CHANGELOG README
	dohtml doc/index.html
	docinto test
	dodoc test/*
}
