
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/multisync-gui/multisync-gui-0.92.0_pre20080531.ebuild,v 1.1 2008/05/31 14:12:49 loki_val Exp $

inherit toolchain-funcs cmake-utils

DESCRIPTION="OpenSync multisync-gui"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=app-pda/libopensync-0.36
	>=dev-libs/libxml2-2.6.30
	>=gnome-base/libglade-2.6.2
	>=x11-libs/gtk+-2.6
	dev-libs/atk"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.22"

pkg_postinst() {
	elog "${CATEGORY}/${PF} contains support for syncing with"
	elog "the Evolution mail client. To take advantage of this, do:"
	elog "# emerge mail-client/evolution"
}
