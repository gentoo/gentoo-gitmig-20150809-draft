# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.6_rc3.ebuild,v 1.1 2004/03/20 21:29:09 centic Exp $

inherit kde-base
need-kde 3

MY_P="${P/_rc/rc}"

DESCRIPTION="Personal Finances Manager for KDE"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://kmymoney2.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

IUSE=""
SLOT="0"

DEPEND="libxml2 libxmlpp"

S="${WORKDIR}/${MY_P}"

