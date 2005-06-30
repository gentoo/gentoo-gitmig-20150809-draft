# Copyright James Harlow 2003
# Distributed under the GNU GPL v2

inherit kde-base

LICENSE="GPL-2"
DESCRIPTION="KLapJack - a KDE client for the popular online journal site LiveJournal."
SRC_URI="mirror://sourceforge/klapjack/${P}.tar.gz"
HOMEPAGE="http://klapjack.sourceforge.net/"
KEYWORDS="~x86"
DEPEND=">=kde-base/kdebase-3.0 \
		>=x11-libs/qt-3.1 \
		>=media-sound/xmms-1.2.7 \
		>=dev-libs/xmlrpc-c-0.9.9"

need-kde 3
