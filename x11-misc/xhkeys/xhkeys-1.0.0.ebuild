# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xhkeys/xhkeys-1.0.0.ebuild,v 1.2 2004/04/19 07:19:40 mr_bones_ Exp $

DESCRIPTION="assign particular actions to any key or key combination"
HOMEPAGE="http://www.geocities.com/wmalms/"
SRC_URI="http://www.geocities.com/wmalms/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

src_install() {
	dobin xhkeys xhkconf
	dodoc README VERSION
}
