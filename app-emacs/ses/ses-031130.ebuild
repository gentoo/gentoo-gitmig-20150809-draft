# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ses/ses-031130.ebuild,v 1.1 2006/01/11 21:45:23 mkennedy Exp $

inherit elisp

DESCRIPTION="SES is the Simple Emacs Spreadsheet."
HOMEPAGE="http://home.comcast.net/~jyavner/ses/"
SRC_URI="http://home.comcast.net/~jyavner/ses/ses21-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/emacs"

S=${WORKDIR}/ses21-${PV}

src_unpack() {
	unpack ${A}
	rm ${S}/*.elc
}

src_compile() {
	elisp-comp *.el || die
}

src_install() {
	elisp-install ses *.{el,elc}
	elisp-site-file-install ${FILESDIR}/50ses-gentoo.el
	dodoc ses-readme.txt
	insinto /usr/share/doc/${PF}
	doins ses-example.ses
}
