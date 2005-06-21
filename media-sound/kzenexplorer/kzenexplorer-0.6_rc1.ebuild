# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kzenexplorer/kzenexplorer-0.6_rc1.ebuild,v 1.2 2005/06/21 07:35:53 dholm Exp $

inherit kde eutils
need-kde 3.3

DESCRIPTION="A QT frontend for libnjb and its supported players."
HOMEPAGE="http://kzenexplorer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="${DEPEND}
	>=media-libs/libnjb-2.0
	>=media-libs/taglib-1.3"
