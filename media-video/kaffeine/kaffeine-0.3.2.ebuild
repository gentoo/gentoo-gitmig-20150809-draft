# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.3.2.ebuild,v 1.1 2003/08/14 15:13:08 sergey Exp $
inherit kde-base
need-kde 3

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
SRC_URI="http://members.chello.at/kaffeine/download/${P}.tar.gz"
HOMEPAGE="http://members.chello.at/kaffeine"
LICENSE="GPL-2"
IUSE=""
newdepend ">=media-libs/xine-lib-1_beta4
			 sys-devel/gettext"
SLOT="0"
KEYWORDS="~x86"
