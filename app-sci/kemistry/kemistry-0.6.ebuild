# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kemistry/kemistry-0.6.ebuild,v 1.6 2003/02/13 09:22:33 vapier Exp $

newdepend "kde-base/kdesdk"

PATCHES="${FILESDIR}/${P}-gcc3.2.patch"
inherit kde-base
need-kde 3.0
IUSE=""
KEYWORDS="x86"
LICENSE="GPL-2"
S="${WORKDIR}/${PN}"
DESCRIPTION="Kemistry--a set of chemistry related tools for KDE."
SRC_URI="mirror://sourceforge/kemistry/${P}.tar.bz2"
HOMEPAGE="http://kemistry.sourceforge.net"

