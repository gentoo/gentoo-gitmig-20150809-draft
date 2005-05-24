# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-fuzzy/cl-rsm-fuzzy-1.2-r2.ebuild,v 1.3 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="R. Scott McIntire's Common Lisp Fuzzy Logic Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/cl-rsm-fuzzy.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rsm-fuzzy/cl-rsm-fuzzy_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp "

CLPACKAGE=rsm-fuzzy

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-format-args-gentoo.patch
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
