# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-10.0g.ebuild,v 1.8 2004/03/04 18:58:08 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="AUC TeX is an extensible package that supports writing and formatting TeX files"
HOMEPAGE="http://www.gnu.org/software/auctex/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-apps/sed-4
	virtual/emacs
	virtual/tetex"

S="${WORKDIR}/${P}"

pkg_setup() {

	if ! grep ' Xaw3d' /var/db/pkg/app-editors/emacs*/USE >/dev/null 2>&1 ; then
		ewarn
		ewarn "Emacs needs to be compiled with Xaw3d support."
		ewarn "Please emerge emacs with USE=\"Xaw3d\"."
		ewarn
		die "Emacs Xaw3d support must be enabled."
	fi
}

src_unpack() {
	unpack ${A}
	sed -i 's,/usr/local/lib/texmf/tex/,/usr/share/texmf/tex/,g' ${S}/tex.el || die
}

src_compile() {
	make || die
	cd doc
	sed -i "/^auctex/s/\(-.\)/\.info\1/g" auctex
	for i in auctex* ; do
		mv $i auctex.info${i#auctex}
	done
}

src_install() {
	dodir ${SITELISP}/${PN}
	make lispdir=${D}${SITELISP} install install-contrib || die
	dosed ${SITELISP}/tex-site.el || die
	doinfo doc/auctex*
	elisp-site-file-install ${FILESDIR}/50auctex-gentoo.el
	dodoc ChangeLog CHANGES COPYING INSTALLATION PROBLEMS README NEWS INSTALL
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
