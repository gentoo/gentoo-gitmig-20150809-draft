# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.5_rc2.ebuild,v 1.2 2004/11/24 23:08:51 centic Exp $

inherit kde

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P/_/-}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=media-libs/xine-lib-1_rc5
	sys-devel/gettext"
need-kde 3.2

S="${WORKDIR}/${P/_/-}"
