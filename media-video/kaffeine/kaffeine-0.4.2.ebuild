# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.4.2.ebuild,v 1.6 2004/07/03 21:52:54 carlo Exp $

inherit kde

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"

LICENSE="GPL-2"
IUSE=""

SLOT="0"
KEYWORDS="~x86 amd64 ~ppc"

DEPEND=">=media-libs/xine-lib-1_rc3
	sys-devel/gettext"
need-kde 3.1