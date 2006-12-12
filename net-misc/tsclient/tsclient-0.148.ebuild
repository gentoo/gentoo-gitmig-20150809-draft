# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsclient/tsclient-0.148.ebuild,v 1.5 2006/12/12 15:04:30 wolf31o2 Exp $

inherit eutils

DESCRIPTION="GTK2 frontend for rdesktop"
HOMEPAGE="http://www.gnomepro.com/tsclient"
SRC_URI="http://www.gnomepro.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc sparc x86"
IUSE="debug vnc"

RDEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=net-misc/rdesktop-1.3.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/gnome-panel-2.0
	vnc? (
		|| (
			net-misc/vnc
			net-misc/tightvnc ) )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.27
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable debug) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS NEWS README VERSION
}

pkg_postinst() {
	if use vnc
	then
		ewarn "VNC support is still experimental.  Be sure to read"
		ewarn "/usr/share/doc/${PF}/README.gz for more infomration."
		echo
	fi
}
