# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yow/yow-21.4_p20020329.ebuild,v 1.1 2007/11/20 16:48:01 ulm Exp $

inherit elisp eutils

MY_P="emacs-${PV%_p*}"
DESCRIPTION="Zippy the pinhead data base"
HOMEPAGE="http://www.gnu.org/software/emacs/"
SRC_URI="mirror://gnu/emacs/${MY_P}a.tar.gz"

# A slightly different version of yow.lines is also included with
# games-misc/fortune-mod which is under a BSD licence.
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}/etc"
SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-fix-misspellings.patch"
}

src_compile() {
	return
}

src_install() {
	insinto /usr/share/emacs/etc
	doins yow.lines || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
