# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/w3mnav/w3mnav-0.5.ebuild,v 1.6 2005/01/01 14:05:47 eradicator Exp $

inherit elisp

DESCRIPTION="w3mnav.el provides Info-like navigation keys to the w3m Web browser."
HOMEPAGE="http://www.neilvandyke.org/w3mnav/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs
	app-emacs/emacs-w3m"

SITEFILE=60w3mnav-gentoo.el
