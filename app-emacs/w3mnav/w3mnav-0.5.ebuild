# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/w3mnav/w3mnav-0.5.ebuild,v 1.1 2003/10/31 23:03:07 mkennedy Exp $

inherit elisp

DESCRIPTION="w3mnav.el is an Emacs add-on that kludges some Info-like navigation keys to the w3m Web browser. This functionality was originally part of the Scheme support package Quack, and was intended to work with the numerous Scheme books that were converted to HTML from LaTeX format. It also works with some other HTML pages that have book-like \"next page\" and \"previous page\" links."
HOMEPAGE="http://www.neilvandyke.org/w3mnav/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs
	app-emacs/emacs-w3m
	app-emacs/w3mnav"
S=${WORKDIR}/${P}

SITEFILE=60w3mnav-gentoo.el
