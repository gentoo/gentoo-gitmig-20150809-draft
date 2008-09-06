# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkdcraw/libkdcraw-0.1.4.ebuild,v 1.2 2008/09/06 13:01:04 tgurr Exp $

inherit kde

IUSE=""
DESCRIPTION="KDE Image Plugin Interface: a dcraw library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"
SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

RDEPEND="media-gfx/dcraw
	media-libs/lcms"
DEPEND="${RDEPEND}"

need-kde 3
