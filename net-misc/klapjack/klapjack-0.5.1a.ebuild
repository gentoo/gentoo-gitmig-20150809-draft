# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/klapjack/klapjack-0.5.1a.ebuild,v 1.2 2006/10/15 21:17:26 bass Exp $

inherit kde

DESCRIPTION="KLapJack - a KDE client for the popular online journal site LiveJournal."
HOMEPAGE="http://klapjack.sourceforge.net/"
SRC_URI="mirror://sourceforge/klapjack/${P}.tar.gz
		mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/xmlrpc-c-0.9.9
		media-sound/xmms
		png? ( media-libs/libpng )"

need-kde 3

ARTS_REQUIRED=never

src_unpack() {
	kde_src_unpack
	elibtoolize
}
