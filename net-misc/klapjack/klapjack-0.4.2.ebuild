# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/klapjack/klapjack-0.4.2.ebuild,v 1.4 2005/12/02 23:01:43 vapier Exp $

inherit kde-base

DESCRIPTION="KDE client for the online journal site LiveJournal"
HOMEPAGE="http://klapjack.sourceforge.net/"
SRC_URI="mirror://sourceforge/klapjack/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=kde-base/kdebase-3.0
	$(qt_min_version 3.1)
	>=media-sound/xmms-1.2.7
	>=dev-libs/xmlrpc-c-0.9.9"
