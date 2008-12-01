# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/htmlize/htmlize-1.34.ebuild,v 1.6 2008/12/01 20:45:19 tcunha Exp $

inherit elisp

IUSE=""

DESCRIPTION="HTML-ize font-lock buffers in Emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?SaveAsHtml
	http://fly.srk.fer.hr/~hniksic/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

SITEFILE=50htmlize-gentoo.el
