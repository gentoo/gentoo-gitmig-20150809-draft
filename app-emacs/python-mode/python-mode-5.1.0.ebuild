# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/python-mode/python-mode-5.1.0.ebuild,v 1.11 2011/02/20 13:48:06 ulm Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Python source"
HOMEPAGE="https://launchpad.net/python-mode"
# taken from http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}.el"
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 s390 sh x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

S=${WORKDIR}
SITEFILE=60${PN}-gentoo-5.1.el

pkg_postinst() {
	elisp-site-regen
	elog "Note that doctest support is now split out to app-emacs/doctest-mode."
}
