# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-23.3.0.ebuild,v 1.4 2009/11/26 11:10:27 maekke Exp $

inherit eutils

MY_P=${PN}-${PV/./-}
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
# Taken from doc/lispref/ of emacs-23.1
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="FDL-1.3"
SLOT="23"
KEYWORDS="amd64 ppc ~s390 ~sparc x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

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
