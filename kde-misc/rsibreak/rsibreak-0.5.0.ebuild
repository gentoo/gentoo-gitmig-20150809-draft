# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.5.0.ebuild,v 1.3 2006/03/11 14:33:40 flameeyes Exp $

inherit kde

DESCRIPTION="A small utility which bothers you at certain intervals"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.omat.nl/drupal/?q=node/23"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="|| ( (
			x11-libs/libXext
			x11-libs/libX11
			x11-libs/libXScrnSaver
		) virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xextproto
			x11-proto/xproto
			x11-proto/scrnsaverproto
		) virtual/x11 )"

need-kde 3.3

