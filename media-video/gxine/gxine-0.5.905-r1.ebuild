# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gxine/gxine-0.5.905-r1.ebuild,v 1.5 2011/03/31 16:59:14 xarthisius Exp $

EAPI=2
inherit autotools eutils fdo-mime gnome2-utils multilib nsplugins

DESCRIPTION="GTK+ Front-End for libxine"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~x86"
IUSE="gnome lirc nls nsplugin udev xcb xinerama"

RDEPEND=">=media-libs/xine-lib-1.1.17
	>=x11-libs/gtk+-2.8:2
	>=dev-libs/glib-2.10:2
	>=x11-libs/pango-1.12
	>=dev-lang/spidermonkey-1.9.2.13
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	gnome? ( >=dev-libs/dbus-glib-0.88 )
	lirc? ( app-misc/lirc )
	nls? ( virtual/libintl )
	nsplugin? ( dev-libs/nspr
		x11-libs/libXaw
		x11-libs/libXt )
	udev? ( >=sys-fs/udev-143[extras] )
	xcb? ( x11-libs/libxcb )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-desktop.patch \
		"${FILESDIR}"/${P}-spidermonkey-update.patch \
		"${FILESDIR}"/${P}-fix-nspr-useage.patch

	# need to disable calling of xine-list when running without
	# userpriv, otherwise we get sandbox violations (bug #233847)
	if [[ ${EUID} == "0" ]]; then
		sed -i -e 's:^XINE_LIST=.*$:XINE_LIST=:' configure.ac || die
	fi

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable lirc) \
		--enable-watchdog \
		$(use_with xcb) \
		--with-spidermonkey=/usr/include/js \
		$(use_with nsplugin browser-plugin) \
		$(use_with udev gudev) \
		--without-hal \
		$(use_with gnome dbus) \
		$(use_with xinerama)
}

src_install() {
	emake DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README{,.{cs,de},_l10n} TODO
	use nsplugin && inst_plugin /usr/$(get_libdir)/gxine/gxineplugin.so
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
