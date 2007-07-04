# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mmm-mode/mmm-mode-0.4.8-r1.ebuild,v 1.2 2007/07/04 23:10:48 opfer Exp $

inherit elisp

DESCRIPTION="Enables the user to edit different parts of a file in different major modes"
HOMEPAGE="http://mmm-mode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE=50mmm-mode-gentoo.el

src_compile() {
	econf --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-emacs \
		--with-listdir=${SITELISP}/${PN} \
		--mandir=/usr/share/man || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo *.info*
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README README.Mason TODO
}
