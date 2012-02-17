# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/polkit-gnome/polkit-gnome-0.105.ebuild,v 1.4 2012/02/17 15:36:44 tomka Exp $

EAPI=4
inherit gnome.org

DESCRIPTION="A dbus session bus service that is used to bring up authentication dialogs"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/PolicyKit"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.30
	>=sys-auth/polkit-0.102
	x11-libs/gtk+:3
	!lxde-base/lxpolkit"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS=( AUTHORS HACKING NEWS README TODO )

src_install() {
	default

	cat <<-EOF > "${T}"/polkit-gnome-authentication-agent-1.desktop
	[Desktop Entry]
	Name=PolicyKit Authentication Agent
	Comment=PolicyKit Authentication Agent
	Exec=/usr/libexec/polkit-gnome-authentication-agent-1
	Terminal=false
	Type=Application
	Categories=
	NoDisplay=true
	NotShowIn=KDE;
	AutostartCondition=GNOME3 if-session gnome-fallback
	EOF

	insinto /etc/xdg/autostart
	doins "${T}"/polkit-gnome-authentication-agent-1.desktop
}
