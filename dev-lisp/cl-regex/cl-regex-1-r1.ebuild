# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-regex/cl-regex-1-r1.ebuild,v 1.7 2007/02/03 17:41:14 flameeyes Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp regular expression compiler/matcher"
HOMEPAGE="http://www.geocities.com/mparker762/clawk.html http://packages.debian.org/unstable/devel/cl-regex.html"
SRC_URI="mirror://debian/pool/main/c/cl-regex/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=regex

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
