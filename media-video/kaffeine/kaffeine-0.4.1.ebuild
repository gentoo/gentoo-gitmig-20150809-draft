# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.4.1.ebuild,v 1.2 2004/02/08 20:34:12 sergey Exp $
inherit kde-base
need-kde 3.1

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://kaffeine.sourceforge.net/"
LICENSE="GPL-2"
IUSE=""

SLOT="0"
KEYWORDS="~x86"

DEPEND="${DEPEND}
	>=media-libs/xine-lib-1_rc0
	sys-devel/gettext"
