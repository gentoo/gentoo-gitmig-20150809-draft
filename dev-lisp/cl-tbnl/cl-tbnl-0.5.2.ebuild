# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-tbnl/cl-tbnl-0.5.2.ebuild,v 1.1 2005/03/26 23:21:42 mkennedy Exp $

inherit common-lisp

DESCRIPTION="TBNL is a toolkit for building dynamic websites with Common Lisp based on mod_lisp."
HOMEPAGE="http://www.weitz.de/tbnl/"
SRC_URI="mirror://gentoo/tbnl_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="apache2"

DEPEND="dev-lisp/cl-kmrcl
	dev-lisp/cl-md5
	dev-lisp/cl-base64
	dev-lisp/cl-url-rewrite
	dev-lisp/cl-ppcre"

# RDEPEND="${DEPEND}
#	apache2? ( www-apache/mod_lisp2 ) !apache2? ( www-apache/mod_lisp )"

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
