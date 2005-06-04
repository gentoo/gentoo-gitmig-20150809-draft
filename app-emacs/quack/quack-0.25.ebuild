# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/quack/quack-0.25.ebuild,v 1.3 2005/06/04 19:12:34 dertobi123 Exp $

inherit elisp

DESCRIPTION="Quack enhances Emacs support for Scheme."
HOMEPAGE="http://www.neilvandyke.org/quack/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/emacs
	app-emacs/emacs-w3m
	app-emacs/w3mnav"

SITEFILE=70quack-gentoo.el
