# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlize/htmlize-1.16.ebuild,v 1.7 2005/06/29 17:45:49 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="HTML-ize font-lock buffers in Emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?SaveAsHtml
	http://fly.srk.fer.hr/~hniksic/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc x86 ~amd64"

SITEFILE=50htmlize-gentoo.el

