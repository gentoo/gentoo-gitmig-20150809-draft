# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksynaptics/ksynaptics-0.3.1.ebuild,v 1.1 2006/03/28 17:15:56 trapni Exp $

inherit kde

DESCRIPTION="synaptics touchpad configuration tool"
HOMEPAGE="http://qsynaptics.sourceforge.net/"
SRC_URI="http://qsynaptics.sourceforge.net/${P}.tar.bz2"

DEPEND=">=x11-libs/libsynaptics-0.14.4d"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

need-kde 3.1
