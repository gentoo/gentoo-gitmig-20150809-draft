# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.7.3.ebuild,v 1.2 2003/10/19 20:13:09 lanius Exp $

inherit kde
need-kde 3

IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="mirror://sourceforge/kopete/${P}.tar.bz2"
HOMEPAGE="http://kopete.kde.org/"

newdepend "dev-libs/libxml2
	dev-libs/libxslt"
