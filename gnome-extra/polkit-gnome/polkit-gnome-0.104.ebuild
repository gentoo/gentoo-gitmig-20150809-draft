# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/polkit-gnome/polkit-gnome-0.104.ebuild,v 1.2 2011/10/18 17:31:51 ssuominen Exp $

EAPI=4
inherit gnome.org

DESCRIPTION="A dbus session bus service that is used to bring up authentication dialogs"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples +introspection"

RDEPEND=">=sys-auth/polkit-0.102[introspection?]
	x11-libs/gtk+:3[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )
	!lxde-base/lxpolkit"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1.3 )"
	# gnome-base/gnome-common
	# dev-util/gtk-doc-am

DOCS=( AUTHORS HACKING NEWS README TODO )

src_configure() {
	econf \
		--disable-static \
		$(use_enable doc gtk-doc) \
		$(use_enable examples) \
		$(use_enable introspection) \
		--with-html-dir=/usr/share/doc/${PF}/html
}

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
