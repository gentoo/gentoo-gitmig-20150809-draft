# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-fare-matcher/cl-fare-matcher-1.1-r1.ebuild,v 1.1 2004/02/12 09:13:13 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A library of macros and functions by Fare Rideau."
HOMEPAGE="http://mapcar.org/~mrd/utilities/matcher.html
	http://www.cliki.net/fare-matcher
	http://www.cliki.net/fare-matcher-docs"
SRC_URI="http://mapcar.org/~mrd/utilities/fare-matcher-ext-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

S=${WORKDIR}/matcher

CLPACKAGE=fare-matcher

src_unpack() {
	unpack ${A}
	# maybe we should consider having clisp.sh pass -E utf8 to clisp
	epatch ${FILESDIR}/clisp-utf8-gentoo.patch
}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
}

pkg_postinst() {
	register-common-lisp-source ${CLPACKAGE}
	while read line; do einfo ${line}; done <<EOF

The comments within the source for fare-matcher provide documentation.
You can find summarized documentation at the CLiki.

	http://www.cliki.net/fare-matcher-docs

EOF
}