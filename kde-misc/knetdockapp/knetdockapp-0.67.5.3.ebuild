# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetdockapp/knetdockapp-0.67.5.3.ebuild,v 1.3 2007/06/16 19:01:18 philantrop Exp $

inherit kde
need-kde 3

DESCRIPTION="Network interface monitor panel applet"
HOMEPAGE="http://pan4os.info"
SRC_URI="http://pan4os.info/apps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# Broken on amd64, upstream responsive but not cooperative.
# cf. bug 179924.
KEYWORDS="-amd64 x86"
IUSE=""
