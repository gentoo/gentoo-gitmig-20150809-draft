# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.4.1.ebuild,v 1.6 2003/02/13 14:10:42 vapier Exp $

IUSE=""

inherit kde-base || die

need-kde 3

LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="http://www.cron.cl/kopete/${P}.tar.gz"
HOMEPAGE="http://kopete.kde.org/"

