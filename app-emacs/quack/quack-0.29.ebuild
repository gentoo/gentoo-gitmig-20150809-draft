# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/quack/quack-0.29.ebuild,v 1.1 2007/02/08 18:04:59 opfer Exp $

inherit elisp

DESCRIPTION="Enhances Emacs support for Scheme."
HOMEPAGE="http://www.neilvandyke.org/quack/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="app-emacs/emacs-w3m
	app-emacs/w3mnav"

SITEFILE=70quack-gentoo.el
