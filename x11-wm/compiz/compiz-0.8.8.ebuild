# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz/compiz-0.8.8.ebuild,v 1.4 2012/07/23 05:07:23 naota Exp $

EAPI=4
inherit autotools eutils gnome2-utils

DESCRIPTION="OpenGL window and compositing manager"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+cairo dbus fuse gnome gconf gtk kde +svg"

COMMONDEPEND="
	>=dev-libs/glib-2
	dev-libs/libxml2
	dev-libs/libxslt
	media-libs/libpng:0
	>=media-libs/mesa-6.5.1-r1
	>=x11-base/xorg-server-1.1.1-r1
	>=x11-libs/libX11-1.4
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libICE
	x11-libs/libSM
	>=x11-libs/libXrender-0.8.4
	>=x11-libs/startup-notification-0.7
	cairo? (
		x11-libs/cairo[X]
	)
	dbus? ( >=sys-apps/dbus-1.0 )
	fuse? ( sys-fs/fuse )
	gnome? (
		>=gnome-base/gnome-control-center-2.16.1:2
		gnome-base/gnome-desktop:2
		gconf? ( gnome-base/gconf:2 )
	)
	gtk? (
		>=x11-libs/gtk+-2.8.0:2
		>=x11-libs/libwnck-2.18.3:1
		x11-libs/pango
	)
	kde? (
		|| (
			>=kde-base/kwin-4.2.0
			kde-base/kwin:live
		)
	)
	svg? (
		>=gnome-base/librsvg-2.14.0:2
		>=x11-libs/cairo-1.0
	)
"

DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	x11-proto/damageproto
	x11-proto/xineramaproto
"

RDEPEND="${COMMONDEPEND}
	x11-apps/mesa-progs
	x11-apps/xvinfo
"

src_prepare() {
	echo gtk/gnome/compiz-wm.desktop.in >> po/POTFILES.skip
	echo metadata/core.xml.in >> po/POTFILES.skip

	if ! use gnome || ! use gconf; then
		epatch "${FILESDIR}"/${PN}-no-gconf.patch
	fi
	# patch for KDE 4.8. Picked up from stuff overlay
	if use kde; then
		has_version ">=kde-base/kwin-4.8" && epatch "${FILESDIR}"/${PN}-kde-4.8.patch
	fi
	eautoreconf
}

src_configure() {
	local myconf

	# We make gconf optional by itself, but only if gnome is also
	# enabled, otherwise we simply disable it.
	if use gnome; then
		myconf="${myconf} $(use_enable gconf)"
	else
		myconf="${myconf} --disable-gconf"
	fi

	econf \
		--enable-fast-install \
		--disable-static \
		--disable-gnome-keybindings \
		--with-default-plugins \
		$(use_enable svg librsvg) \
		$(use_enable cairo annotate) \
		$(use_enable dbus) \
		$(use_enable dbus dbus-glib) \
		$(use_enable fuse) \
		$(use_enable gnome) \
		$(use_enable gnome metacity) \
		$(use_enable gtk) \
		$(use_enable kde kde4) \
		--disable-kde \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	prune_libtool_files --all

	# Install compiz-manager
	dobin "${FILESDIR}"/compiz-manager

	# Add the full-path to lspci
	sed -i "s#lspci#/usr/sbin/lspci#" "${D}/usr/bin/compiz-manager" || die

	# Fix the hardcoded lib paths
	sed -i "s#/lib/#/$(get_libdir)/#g" "${D}/usr/bin/compiz-manager" || die

	# Create gentoo's config file
	dodir /etc/xdg/compiz

	cat <<- EOF > "${D}/etc/xdg/compiz/compiz-manager"
	COMPIZ_BIN_PATH="/usr/bin/"
	PLUGIN_PATH="/usr/$(get_libdir)/compiz/"
	LIBGL_NVIDIA="/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.so.1.2"
	LIBGL_FGLRX="/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.so.1.2"
	KWIN="$(type -p kwin)"
	METACITY="$(type -p metacity)"
	SKIP_CHECKS="yes"
	EOF

	dodoc AUTHORS ChangeLog NEWS README TODO

	domenu "${FILESDIR}"/compiz.desktop
}

pkg_preinst() {
	use gnome && use gconf && gnome2_gconf_savelist
}

pkg_postinst() {
	use gnome && use gconf && gnome2_gconf_install

	ewarn "If you update to x11-wm/metacity-2.24 after you install ${P},"
	ewarn "gtk-window-decorator will crash until you reinstall ${PN} again."
	elog
	elog "To work with nvidia-drivers, you must enable the AddARGBGLXVisuals option."
}

pkg_prerm() {
	use gnome && gnome2_gconf_uninstall
}
