# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.8.4.ebuild,v 1.2 2004/07/15 14:36:13 pylon Exp $

inherit kde
need-kde 3

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~amd64"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="mirror://sourceforge/kopete/${P}.tar.bz2"
HOMEPAGE="http://kopete.kde.org/"

DEPEND="${DEPEND}
	>=dev-libs/libxml2-2.4.8
	>=dev-libs/libxslt-1.0.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:QTimer::singleShot(15000,:QTimer::singleShot(60000,:' kopete/protocols/irc/libkirc/kirc.cpp
}
