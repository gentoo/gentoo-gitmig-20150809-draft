# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.8.0.ebuild,v 1.1 2004/02/07 17:41:16 lanius Exp $

inherit kde
need-kde 3

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="mirror://sourceforge/kopete/${P}.tar.bz2"
HOMEPAGE="http://kopete.kde.org/"

DEPEND="${DEPEND}
	>=dev-libs/libxml2-2.4.8
	>=dev-libs/libxslt-1.0.7
	!>=kde-base/kdelibs-3.2"
