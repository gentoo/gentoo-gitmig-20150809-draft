# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.4.3b.ebuild,v 1.2 2004/06/15 02:30:27 agriffis Exp $

inherit kde

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=media-libs/xine-lib-1_rc4
	sys-devel/gettext"

need-kde 3.1
