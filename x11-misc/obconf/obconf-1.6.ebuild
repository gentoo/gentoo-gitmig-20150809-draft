# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-1.6.ebuild,v 1.12 2007/04/22 01:18:56 kloeri Exp $

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
HOMEPAGE="http://tr.openmonkey.com/pages/obconf"
SRC_URI="http://tr.openmonkey.com/files/obconf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
