# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-xfire/gaim-xfire-0.6.0.ebuild,v 1.2 2007/07/11 20:39:23 mr_bones_ Exp $

DESCRIPTION="Xfire plugin for gaim."
HOMEPAGE="http://www.fryx.ch/xfire/"
SRC_URI="mirror://sourceforge/gfire/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0"

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
}
