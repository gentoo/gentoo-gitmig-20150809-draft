# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xhkeys/xhkeys-2.2.1.ebuild,v 1.4 2006/01/21 17:29:41 nelchael Exp $

DESCRIPTION="assign particular actions to any key or key combination"
HOMEPAGE="http://www.geocities.com/wmalms/"
SRC_URI="http://www.geocities.com/wmalms/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xextproto
		x11-proto/xproto )
	virtual/x11 )"

src_install() {
	dobin xhkeys xhkconf
	dodoc README VERSION
}
