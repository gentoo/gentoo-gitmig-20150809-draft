# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/quack/quack-0.22.ebuild,v 1.1 2003/10/31 23:04:10 mkennedy Exp $

inherit elisp

DESCRIPTION="Quack enhances Emacs support for Scheme."
HOMEPAGE="http://www.neilvandyke.org/quack/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs
	app-emacs/emacs-w3m
	app-emacs/w3mnav"
S=${WORKDIR}/${P}

SITEFILE=70quack-gentoo.el
