# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.5.ebuild,v 1.3 2002/11/04 13:34:57 hannes Exp $

PATCHES="${FILESDIR}/${P}-qt-3.1.patch"

inherit kde-base
need-kde 3

IUSE=""
S="${WORKDIR}/${P}-1"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="http://www.cron.cl/kopete/${P}-1.tar.gz"
HOMEPAGE="http://kopete.kde.org/"
