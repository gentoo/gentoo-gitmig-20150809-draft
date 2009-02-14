# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kzenexplorer/kzenexplorer-0.6-r1.ebuild,v 1.1 2009/02/14 00:11:51 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A QT frontend for libnjb and its supported players."
HOMEPAGE="http://kzenexplorer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/libnjb-2.0
	>=media-libs/taglib-1.3"
need-kde 3.5
