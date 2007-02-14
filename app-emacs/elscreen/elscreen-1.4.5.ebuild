# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/elscreen/elscreen-1.4.5.ebuild,v 1.1 2007/02/14 18:41:34 opfer Exp $

inherit elisp

DESCRIPTION="Frame configuration management for GNU Emacs modelled after GNU Screen"
HOMEPAGE="http://www.morishima.net/~naoto/j/software/elscreen/"
SRC_URI="ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-emacs/apel"

SITEFILE=60elscreen-gentoo.el

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog README
}
