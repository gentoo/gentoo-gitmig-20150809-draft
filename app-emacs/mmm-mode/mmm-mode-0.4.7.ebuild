# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mmm-mode/mmm-mode-0.4.7.ebuild,v 1.5 2004/06/01 14:09:05 vapier Exp $

inherit elisp

DESCRIPTION="Enables the user to edit different parts of a file in different major modes"
HOMEPAGE="http://mmm-mode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=50mmm-mode-gentoo.el

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	doinfo *.info*
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README README.Mason TODO
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
