# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-0.4.3b-r1.ebuild,v 1.3 2004/11/23 22:46:42 carlo Exp $

inherit kde eutils

DESCRIPTION="The Kaffeine media player for KDE3 based on xine-lib."
HOMEPAGE="http://kaffeine.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaffeine/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc amd64"
IUSE=""

DEPEND=">=media-libs/xine-lib-1_rc4
	sys-devel/gettext"

need-kde 3.1

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-SecurityTracker-1011936.patch
}
