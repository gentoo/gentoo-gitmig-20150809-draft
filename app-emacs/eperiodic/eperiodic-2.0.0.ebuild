# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/eperiodic/eperiodic-2.0.0.ebuild,v 1.1 2007/12/03 21:29:50 ulm Exp $

inherit elisp

DESCRIPTION="Periodic Table for Emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki?action=browse&id=MattHodges"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SIMPLE_ELISP=t
SITEFILE=50${PN}-gentoo.el
