# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.3.ebuild,v 1.4 2003/01/22 22:41:33 nall Exp $
inherit kde-base

need-kde 3

IUSE=""
DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="http://xm1.net.free.fr/kile/${P}.tar.gz"
HOMEPAGE="http://xm1.net.free.fr/kile/index.html"

DEPEND="$DEPEND sys-devel/perl"
RDEPEND="${RDEPEND} app-text/tetex"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"

#fix #11173
PATCHES="$FILESDIR/$P-qt-no-stl.diff"
