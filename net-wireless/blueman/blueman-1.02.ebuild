# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/blueman/blueman-1.02.ebuild,v 1.1 2009/03/01 09:09:17 dev-zero Exp $

EAPI="2"

DESCRIPTION="GTK+ Bluetooth Manager, designed to be simple and intuitive for everyday bluetooth tasks."
HOMEPAGE="http://blueman-project.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="network nls"

CDEPEND="dev-libs/glib:2
	>=x11-libs/gtk+-2.12:2
	x11-libs/startup-notification
	>=dev-lang/python-2.5	
	dev-python/pygobject
	dev-python/dbus-python
	dev-python/notify-python
	dev-python/pygtk
	net-wireless/bluez"
DEPEND="${CDEPEND}
	nls? ( dev-util/intltool sys-devel/gettext )
	dev-util/pkgconfig
	>=dev-python/pyrex-0.9.8"
RDEPEND="${CDEPEND}
	>=app-mobilephone/obex-data-server-0.4.4
	gnome-extra/policykit-gnome
	x11-misc/notification-daemon
	dev-python/gconf-python
	sys-apps/dbus
	network? ( || ( net-dns/dnsmasq =net-misc/dhcp-3* ) )"
	

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
