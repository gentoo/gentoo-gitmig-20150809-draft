# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-1.6.ebuild,v 1.4 2006/10/16 02:05:26 omp Exp $

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
HOMEPAGE="http://tr.openmonkey.com/pages/obconf"
SRC_URI="http://tr.openmonkey.com/files/obconf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.2"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
