# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-2.0.0.ebuild,v 1.1 2007/06/05 23:28:30 omp Exp $

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
HOMEPAGE="http://icculus.org/openbox/index.php/ObConf:About"
SRC_URI="http://icculus.org/openbox/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
