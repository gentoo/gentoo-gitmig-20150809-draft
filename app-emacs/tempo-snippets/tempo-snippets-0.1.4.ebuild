# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tempo-snippets/tempo-snippets-0.1.4.ebuild,v 1.1 2008/07/30 13:42:20 ulm Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="Visual insertion of tempo templates"
HOMEPAGE="http://nschum.de/src/emacs/tempo-snippets/
	http://www.emacswiki.org/cgi-bin/wiki/TempoSnippets"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
