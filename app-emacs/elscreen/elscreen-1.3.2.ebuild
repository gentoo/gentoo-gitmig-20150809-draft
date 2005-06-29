# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/elscreen/elscreen-1.3.2.ebuild,v 1.2 2005/06/29 17:33:04 mkennedy Exp $

inherit elisp

DESCRIPTION="Frame configuration management for GNU Emacs modelled after GNU Screen"
HOMEPAGE="http://www.morishima.net/~naoto/j/software/elscreen/"
# SRC_URI="ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/${P}.tar.gz"
SRC_URI="http://ftp.debian.org/debian/pool/main/e/elscreen/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
IUSE=""

DEPEND="virtual/emacs
	app-emacs/apel"

SITEFILE=60elscreen-gentoo.el

src_compile() {
	elisp-compile *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc ChangeLog README
}
