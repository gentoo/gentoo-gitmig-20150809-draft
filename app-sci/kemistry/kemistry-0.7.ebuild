# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit kde

DESCRIPTION="Kemistry--a set of chemistry related tools for KDE."
HOMEPAGE="http://kemistry.sourceforge.net"
SRC_URI="mirror://sourceforge/kemistry/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND="kde-base/kdesdk"
need-kde 3
