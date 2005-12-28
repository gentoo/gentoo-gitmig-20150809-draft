# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/klapjack/klapjack-0.5.1a.ebuild,v 1.1 2005/12/28 12:00:10 bass Exp $

inherit kde

DESCRIPTION="KLapJack - a KDE client for the popular online journal site LiveJournal."
HOMEPAGE="http://klapjack.sourceforge.net/"
SRC_URI="mirror://sourceforge/klapjack/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="xmms"

DEPEND="xmms? ( >=media-sound/xmms-1.2.7 )
	>=dev-libs/xmlrpc-c-0.9.9
	kde-base/arts"

need-kde 3

src_unpack() {
	kde_src_unpack
	elibtoolize
}
