# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-regex/cl-regex-1-r1.ebuild,v 1.1 2004/02/12 09:13:19 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Common Lisp regular expression compiler/matcher"
HOMEPAGE="http://www.geocities.com/mparker762/clawk.html
	http://packages.debian.org/unstable/devel/cl-regex.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-regex/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=regex

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-macs.lisp-gentoo.patch
}

src_install() {
	common-lisp-install closure.lisp gen.lisp macs.lisp optimize.lisp \
		packages.lisp parser.lisp regex.lisp ${FILESDIR}/regex.asd
	common-lisp-system-symlink
	dodoc license.txt
	docinto examples
	dodoc *test*.lisp
}
