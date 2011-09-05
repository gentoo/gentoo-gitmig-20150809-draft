# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-23.3.0-r1.ebuild,v 1.6 2011/09/05 13:58:41 naota Exp $

inherit eutils

MY_P=${PN}-${PV/./-}
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
# taken from http://www.gnu.org/software/emacs/manual/texi/elisp.texi.tar.gz
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="FDL-1.3"
SLOT="23"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/lispref"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-direntry.patch"
}

src_compile() {
	makeinfo elisp.texi || die "makeinfo failed"
}

src_install() {
	doinfo elisp23.info* || die "doinfo failed"
	dodoc ChangeLog README
}
