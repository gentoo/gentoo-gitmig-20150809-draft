# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/muine/muine-0.8.7.ebuild,v 1.3 2007/07/12 14:51:16 drac Exp $

inherit gnome2 mono eutils multilib autotools

DESCRIPTION="A music player for GNOME"
HOMEPAGE="http://muine-player.org/"
SRC_URI="http://muine-player.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aac flac mad vorbis xine "

# The GTK+ depend is not superflous, it is to get the correct version
RDEPEND=">=dev-lang/mono-1.1
	>=x11-libs/gtk+-2.6.0
	>=dev-dotnet/gtk-sharp-2.6.0
	>=dev-dotnet/glade-sharp-2.6.0
	>=dev-dotnet/gnome-sharp-2.6.0
	>=dev-dotnet/gconf-sharp-2.6.0
	>=dev-dotnet/gnomevfs-sharp-2.6.0
	sys-libs/gdbm
	>=media-libs/flac-1.1.2
	>=media-libs/libvorbis-1.0
	>=media-libs/libid3tag-0.15.0b
	xine? ( >=media-libs/xine-lib-1_rc4 )
	!xine? (
		=media-libs/gstreamer-0.10*
		=media-libs/gst-plugins-base-0.10*
		=media-libs/gst-plugins-good-0.10*
		=media-plugins/gst-plugins-gconf-0.10*
		=media-plugins/gst-plugins-gnomevfs-0.10*
		aac? ( =media-plugins/gst-plugins-faad-0.10*
			>=media-libs/faad2-2.0-r4 )
		flac? ( =media-plugins/gst-plugins-flac-0.10* )
		mad? ( =media-plugins/gst-plugins-mad-0.10* )
		vorbis? ( =media-plugins/gst-plugins-ogg-0.10*
			=media-plugins/gst-plugins-vorbis-0.10* )
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper
	gnome-base/gnome-common
	>=dev-util/intltool-0.29
	>=dev-util/monodoc-1.1.8"

DOCS="AUTHORS COPYING ChangeLog INSTALL MAINTAINERS NEWS README TODO"

# The build is not parallel safe
MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable aac faad2)"

	if use xine ; then
		G2CONF="${G2CONF} --enable-xine"
	else
		G2CONF="${G2CONF} --enable-gstreamer=0.10"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-flac.patch
	intltoolize --force --copy || die "intltoolize failed"
	AT_M4DIR="${S}/m4" eautoreconf
}

src_install() {
	gnome2_src_install "$@"

	insinto /usr/$(get_libdir)/muine/plugins/
	doins ${S}/plugins/TrayIcon.dll
}

pkg_postinst() {
	elog
	elog "Upstream no longer packages the tray icon plugin by default."
	elog "The Gentoo ebuilds will continue to install the plugin, if you don't"
	elog "want to use the plugin, remove TrayIcon.dll from"
	elog "/usr/$(get_libdir)/muine/plugins/"
	elog
}
