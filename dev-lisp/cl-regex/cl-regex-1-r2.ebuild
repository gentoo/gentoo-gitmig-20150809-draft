# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-regex/cl-regex-1-r2.ebuild,v 1.4 2009/12/15 19:36:19 ssuominen Exp $

inherit common-lisp eutils

DESCRIPTION="Common Lisp regular expression compiler/matcher"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-regex"
SRC_URI="mirror://debian/pool/main/c/cl-regex/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-plus"

CLPACKAGE=regex

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/defconstant-gentoo.patch
}

src_install() {
	common-lisp-install closure.lisp gen.lisp macs.lisp optimize.lisp \
		packages.lisp parser.lisp regex.lisp ${FILESDIR}/regex.asd
	common-lisp-system-symlink
	dodoc license.txt
	docinto examples
	dodoc *test*.lisp
}
