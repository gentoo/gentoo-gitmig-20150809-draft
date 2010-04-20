# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlfontify/htmlfontify-0.20-r1.ebuild,v 1.4 2010/04/20 19:51:06 ulm Exp $

inherit elisp

MY_P=${PN}_${PV}+texinfo
DESCRIPTION="Turn an Emacs buffer into display-equivalent HTML"
HOMEPAGE="http://rtfm.etla.org/emacs/htmlfontify/"
SRC_URI="http://rtfm.etla.org/emacs/htmlfontify/${MY_P}.tar.gz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

# Package cannot be compiled with Emacs 23 and will be included
# with Emacs 23.2
RDEPEND="!>=app-editors/emacs-23"

S="${WORKDIR}/${MY_P/_/-}"
ELISP_PATCHES="${P}-emacs22.patch"
SITEFILE="51${PN}-gentoo.el"

src_compile() {
	elisp-compile *.el || die "elisp-compile failed"
	makeinfo htmlfontify.texi || die "makeinfo failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo htmlfontify.info
}
