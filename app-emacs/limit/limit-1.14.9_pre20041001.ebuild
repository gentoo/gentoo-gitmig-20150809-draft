# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/limit/limit-1.14.9_pre20041001.ebuild,v 1.5 2005/08/28 02:17:55 tester Exp $

inherit elisp

IUSE=""

DESCRIPTION="LIMIT - Library about Internet Message, for IT generation"
HOMEPAGE="http://pure.fan.gr.jp/simm/?MyWorks"
# SRC_URI="ftp://ftp.fan.gr.jp/pub/elisp/limit/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P/_pre/-}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P/_pre/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc-macos sparc x86"

DEPEND=">=app-emacs/apel-10.3
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
