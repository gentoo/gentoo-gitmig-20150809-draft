# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.8.0.ebuild,v 1.6 2004/07/25 21:31:27 carlo Exp $

inherit kde

DESCRIPTION="The KDE Instant Messenger"
HOMEPAGE="http://kopete.kde.org/"
SRC_URI="mirror://sourceforge/kopete/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.8
	>=dev-libs/libxslt-1.0.7
	<kde-base/kdelibs-3.2"
need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:QTimer::singleShot(15000,:QTimer::singleShot(60000,:' kopete/protocols/irc/libkirc/kirc.cpp
}
