# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-11.14.ebuild,v 1.16 2004/08/24 09:42:13 usata Exp $

inherit elisp

DESCRIPTION="AUCTeX is an extensible package that supports writing and formatting TeX files"
HOMEPAGE="http://www.gnu.org/software/auctex"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 sparc"
IUSE=""

RDEPEND="virtual/emacs
	virtual/tetex"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

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
	dodoc ChangeLog CHANGES INSTALLATION PROBLEMS README
}

pkg_postinst() {
	elisp-site-regen

	if ! grep ' Xaw3d' /var/db/pkg/app-editors/emacs*/USE >/dev/null 2>&1 ; then
		ewarn
		ewarn "Emacs needs to be compiled with Xaw3d support to use the command menu."
		ewarn
	fi
}

pkg_postrm() {
	elisp-site-regen
}
