# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.1.ebuild,v 1.4 2002/10/04 04:09:05 vapier Exp $
inherit kde-base

need-kde 3

DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="http://xm1.net.free.fr/kile/${P}.tar.gz"
HOMEPAGE="http://xm1.net.free.fr/kile/index.html"

DEPEND="$DEPEND sys-devel/perl"
RDEPEND="${RDEPEND} app-text/tetex"

KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"

