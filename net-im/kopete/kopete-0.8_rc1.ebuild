# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.8_rc1.ebuild,v 1.1 2004/01/20 20:34:12 lanius Exp $

inherit kde
need-kde 3

MY_P=${P/_rc/rc}
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="mirror://sourceforge/kopete/${MY_P}.tar.bz2"
HOMEPAGE="http://kopete.kde.org/"
S=${WORKDIR}/${MY_P}

DEPEND=">=dev-libs/libxml2-2.4.8
	>=dev-libs/libxslt-1.0.7
	!=kde-base/kdelibs-3.2*"
