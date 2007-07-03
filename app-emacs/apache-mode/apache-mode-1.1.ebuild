# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/apache-mode/apache-mode-1.1.ebuild,v 1.10 2007/07/03 19:01:26 ulm Exp $

inherit elisp

DESCRIPTION="Major mode for editing Apache configuration files"
HOMEPAGE="http://www.keelhaul.me.uk/linux/#apachemode"
SRC_URI="mirror://gentoo/${P}.el.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SIMPLE_ELISP=t
SITEFILE=50${PN}-gentoo.el
