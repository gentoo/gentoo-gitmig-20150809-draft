# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netspeed_applet/netspeed_applet-0.8.ebuild,v 1.7 2004/07/11 10:27:54 eldad Exp $

IUSE=""
DESCRIPTION="Applet showing network traffic for GNOME 2"
HOMEPAGE="http://mfcn.ilo.de/netspeed_applet/"
SRC_URI="http://mfcn.ilo.de/netspeed_applet/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc"

DEPEND=">=gnome-base/libgnomeui-2
	=gnome-base/libgtop-2.0*
	>=gnome-base/gnome-panel-2"

RDEPEND="${DEPEND}
	>=dev-util/intltool-0.21"



src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	einstall || die

	dodoc README NEWS ChangeLog COPYING AUTHORS INSTALL
}
