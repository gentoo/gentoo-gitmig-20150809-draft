# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/multisync-gui/multisync-gui-0.90.19.ebuild,v 1.4 2008/01/05 17:24:46 peper Exp $

DESCRIPTION="OpenSync multisync-gui"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="evo"

DEPEND="<=app-pda/libopensync-0.35
	evo? ( app-pda/libopensync-plugin-evolution2 )
	>=gnome-base/libgnomeui-2.0"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc README AUTHORS
}
