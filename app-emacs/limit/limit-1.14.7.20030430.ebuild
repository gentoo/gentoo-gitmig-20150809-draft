# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/limit/limit-1.14.7.20030430.ebuild,v 1.3 2003/09/11 00:56:11 msterret Exp $

inherit elisp

IUSE=""

DESCRIPTION="LIMIT - Library about Internet Message, for IT generation"
HOMEPAGE="http://pure.fan.gr.jp/simm/?MyWorks"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ~sparc ~ppc"

DEPEND="virtual/emacs
	>=app-emacs/apel-10.3
	!virtual/flim"

PROVIDE="virtual/flim"

S=${WORKDIR}/flim
SITEFILE=60flim-gentoo.el

src_compile() {
	make PREFIX=${D}/usr \
		LISPDIR=${D}/${SITELISP} \
		VERSION_SPECIFIC_LISPDIR=${D}/${SITELISP} || die
}

src_install() {
	make PREFIX=${D}/usr \
		LISPDIR=${D}/${SITELISP} \
		VERSION_SPECIFIC_LISPDIR=${D}/${SITELISP} install || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc FLIM-API.en NEWS VERSION README* ChangeLog
}
