# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.6.0.ebuild,v 1.1 2003/02/10 21:29:15 ykoehler Exp $

inherit kde-base
need-kde 3

IUSE=""
S="${WORKDIR}/${P}"
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://kopete.kde.org/"
