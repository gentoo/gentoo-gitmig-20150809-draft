# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/junkbust/junkbust-0.9.ebuild,v 1.2 2007/07/03 19:12:21 ulm Exp $

inherit elisp

DESCRIPTION="An Emacs add-on for maintaining a personal configuration of the Junkbuster filtering HTTP proxy"
HOMEPAGE="http://www.neilvandyke.org/junkbust-emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-proxy/junkbuster"

SITEFILE=50${PN}-gentoo.el
