# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ses/ses-031130.ebuild,v 1.4 2007/10/06 20:03:30 ulm Exp $

inherit elisp

DESCRIPTION="Simple Emacs Spreadsheet."
HOMEPAGE="http://home.comcast.net/~jyavner/ses/"
SRC_URI="http://home.comcast.net/~jyavner/ses/ses21-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/ses21-${PV}
SITEFILE=50${PN}-gentoo.el
DOCS="ses-readme.txt ses-example.ses"

src_unpack() {
	unpack ${A}
	rm "${S}"/*.elc
}

src_compile() {
	elisp-comp *.el || die "elisp-comp failed"
}
