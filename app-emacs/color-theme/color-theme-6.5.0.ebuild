# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-theme/color-theme-6.5.0.ebuild,v 1.1 2003/03/20 22:05:40 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Install color themes (includes many themes and allows you to share you won with the world)"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

SITEFILE=50color-theme-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/color-theme.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
