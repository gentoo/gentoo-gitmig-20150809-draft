# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-1.6.ebuild,v 1.3 2006/10/09 12:33:56 gothgirl Exp $

inherit eutils

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
SRC_URI="http://tr.openmonkey.com/files/obconf/${P}.tar.gz"
HOMEPAGE="http://tr.openmonkey.com/pages/obconf"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.2"

src_unpack () {
	unpack ${A}

	epatch ${FILESDIR}/${P}-hideMenuHeader.patch
}

src_install() {
	make DESTDIR="${D}" install || die
}
