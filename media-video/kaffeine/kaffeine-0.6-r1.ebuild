# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.6-r1.ebuild,v 1.1 2005/04/03 14:24:40 greg_g Exp $

inherit kde

DESCRIPTION="Media player for KDE based on xine-lib."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="dvb"

DEPEND=">=x11-base/xorg-x11-6.8.0-r4
	>=media-libs/xine-lib-1
	dvb? ( || ( sys-kernel/linux26-headers
		    >=sys-kernel/linux-headers-2.6 ) )"

# the dependency on xorg-x11 is meant to avoid bug #59746

need-kde 3.2
