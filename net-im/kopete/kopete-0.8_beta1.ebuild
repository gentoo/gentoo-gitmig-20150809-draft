# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.8_beta1.ebuild,v 1.2 2004/01/19 12:03:37 lanius Exp $

inherit kde
need-kde 3

MY_P=${P/_beta/beta}
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="The KDE Instant Messenger"
SRC_URI="mirror://sourceforge/kopete/${MY_P}.tar.bz2"
HOMEPAGE="http://kopete.kde.org/"
S=${WORKDIR}/${MY_P}

DEPEND=">=dev-libs/libxml2-2.4.8
	>=dev-libs/libxslt-1.0.7
	!=kde-base/kdelibs-3.2*"

src_unpack() {
	base_src_unpack
	rm -rf ${S}/doc
}
