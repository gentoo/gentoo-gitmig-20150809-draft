# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-extprefs/gaim-extprefs-0.3.ebuild,v 1.1 2004/09/18 14:50:05 rizzo Exp $

DESCRIPTION="Gaim Extended Preferences is a plugin that takes advantage of existing gaim functionality to provide preferences that are often desired but not are not considered worthy of inclusion in Gaim itself."

HOMEPAGE="http://gaim-extprefs.sourceforge.net"

SRC_URI="mirror://sourceforge/gaim-extprefs/extendedprefs-${PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=net-im/gaim-1.0.0"
#RDEPEND=""

S="${WORKDIR}/extendedprefs-${PV}"

src_compile() {
	#econf || die
	emake || die "emake failed"
}

src_install() {
	make PREFIX=${D}/usr install || die
}
