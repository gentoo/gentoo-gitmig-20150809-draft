# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-1.5-r1.ebuild,v 1.11 2006/10/17 00:30:20 omp Exp $

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
SRC_URI="http://icculus.org/openbox/obconf/${P}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/obconf.php"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.0_beta4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die
}
