# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.6_rc4.ebuild,v 1.4 2004/06/29 11:31:16 carlo Exp $

inherit kde

MY_P="${P/_rc/rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Personal Finances Manager for KDE"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://kmymoney2.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

IUSE=""
SLOT="0"

DEPEND="dev-libs/libxml2
	dev-cpp/libxmlpp"
need-kde 3


