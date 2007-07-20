# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/h4x0r/h4x0r-0.13-r1.ebuild,v 1.3 2007/07/20 07:25:13 nixnut Exp $

inherit elisp

DESCRIPTION="Aid in writing like a script kiddie does"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/emacs/EliteSpeech"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el
