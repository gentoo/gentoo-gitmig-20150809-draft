# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina/remmina-0.7.5.ebuild,v 1.3 2011/03/21 22:15:12 nirbheek Exp $

EAPI=2
inherit gnome2-utils

DESCRIPTION="A GTK+ RDP, VNC, XDMCP and SSH client"
HOMEPAGE="http://remmina.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi crypt nls rdesktop ssh unique vnc vte xdmcp"

RDEPEND="x11-libs/gtk+:2
	avahi? ( net-dns/avahi )
	crypt? ( dev-libs/libgcrypt )
	nls? ( virtual/libintl )
	ssh? ( net-libs/libssh[sftp] )
	unique? ( dev-libs/libunique:1 )
	vnc? ( net-libs/libvncserver )
	vte? ( x11-libs/vte:0 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"
RDEPEND="${RDEPEND}
	rdesktop? ( net-misc/rdesktop )
	xdmcp? ( x11-base/xorg-server[kdrive] )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable avahi) \
		$(use_enable crypt gcrypt) \
		$(use_enable nls) \
		$(use_enable ssh) \
		$(use_enable unique) \
		$(use_enable vnc vnc dl) \
		$(use_enable vte)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
