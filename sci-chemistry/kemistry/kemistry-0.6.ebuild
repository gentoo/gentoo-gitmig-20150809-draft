# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/kemistry/kemistry-0.6.ebuild,v 1.2 2005/01/15 00:14:49 danarmak Exp $

inherit kde

S="${WORKDIR}/${PN}"

DESCRIPTION="Kemistry--a set of chemistry related tools for KDE."
HOMEPAGE="http://kemistry.sourceforge.net"
SRC_URI="mirror://sourceforge/kemistry/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="|| ( kde-base/kdesdk-meta kde-base/kdesdk )"
need-kde 3

PATCHES="${FILESDIR}/${P}-gcc3.2.patch"