# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kemistry/kemistry-0.7.ebuild,v 1.7 2004/08/14 13:30:00 swegener Exp $

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
