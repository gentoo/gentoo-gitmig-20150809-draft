# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.6.ebuild,v 1.1 2005/03/21 14:31:54 greg_g Exp $

inherit kde

DESCRIPTION="Media player for KDE based on xine-lib."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="dvb"

DEPEND=">=media-libs/xine-lib-1
	dvb? ( || ( sys-kernel/linux26-headers
		    >=sys-kernel/linux-headers-2.6 ) )"

need-kde 3.2

src_compile() {
	# See comments in kaffeine/main.cpp.
	# Probably this is not needed, if >=xorg-x11-6.8.0-r4
	# is installed (see bug #75722, #59746).
	local myconf="--with-xorg"

	kde_src_compile
}
