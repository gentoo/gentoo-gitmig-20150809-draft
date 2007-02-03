# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-string/cl-rsm-string-1.3.ebuild,v 1.6 2007/02/03 17:47:28 flameeyes Exp $

inherit common-lisp eutils

DESCRIPTION="R. Scott McIntire's Common Lisp String Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-string.html"
SRC_URI="mirror://gentoo/cl-rsm-string_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-string

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-ftype-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
