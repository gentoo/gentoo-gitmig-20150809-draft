# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.3_beta.ebuild,v 1.1 2002/10/04 11:38:52 danarmak Exp $
inherit kde-base

need-kde 3

DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="http://xm1.net.free.fr/kile/${P//_}.tar.gz"
S="$WORKDIR/${P//_}"
HOMEPAGE="http://xm1.net.free.fr/kile/index.html"

DEPEND="$DEPEND sys-devel/perl"
RDEPEND="${RDEPEND} app-text/tetex"

KEYWORDS="x86"
LICENSE="GPL-2"

