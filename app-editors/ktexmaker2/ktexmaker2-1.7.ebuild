# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ktexmaker2/ktexmaker2-1.7.ebuild,v 1.13 2003/03/11 21:11:44 seemant Exp $
inherit kde-base

need-kde 2.2

DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="http://xm1.net.free.fr/linux/${P}.tar.gz"
HOMEPAGE="http://xm1.net.free.fr/linux/index.html"

DEPEND="$DEPEND dev-lang/perl"
RDEPEND="${RDEPEND} app-text/tetex"


LICENSE="GPL-2"
KEYWORDS="x86 sparc "
