# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmon/wmmon-1.0_beta2.ebuild,v 1.5 2003/06/04 13:47:00 joker Exp $

S=${WORKDIR}/wmmon.app
DESCRIPTION="Dockable system resources monitor applette for WindowMaker"
WMMON_VERSION=1_0b2
SRC_URI="http://rpig.dyndns.org/~anstinus/Linux/wmmon-${WMMON_VERSION}.tar.gz"
HOMEPAGE="http://www.bensinclair.com/dockapp/"

DEPEND="x11-wm/windowmaker"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile() {
	emake -C wmmon || die
}

src_install () {
	dobin wmmon/wmmon
	dodoc BUGS CHANGES COPYING HINTS INSTALL README TODO
}
