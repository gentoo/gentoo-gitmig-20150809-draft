# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/muine/muine-0.8.2.ebuild,v 1.2 2005/04/04 14:56:27 zaheerm Exp $

inherit gnome2 mono eutils

DESCRIPTION="A music player for GNOME"
HOMEPAGE="http://muine.gooeylinux.org/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2"
IUSE="xine mad oggvorbis flac aac"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-lang/mono-0.96
	>=dev-dotnet/gtk-sharp-1.9.1
	>=dev-dotnet/gnome-sharp-1.9.1
	>=dev-dotnet/gnomevfs-sharp-1.9.1
	>=dev-dotnet/glade-sharp-1.9.1
	>=dev-dotnet/gconf-sharp-1.9.1
	xine? ( >=media-libs/xine-lib-1_rc4 )
	!xine? (
		>=media-libs/gstreamer-0.8.9-r3
		>=media-libs/gst-plugins-0.8.8
		>=media-plugins/gst-plugins-gnomevfs-0.8.8
		mad? ( >=media-plugins/gst-plugins-mad-0.8.8 )
		oggvorbis? ( >=media-plugins/gst-plugins-vorbis-0.8.8 )
		flac? ( >=media-plugins/gst-plugins-flac-0.8.8 )
		aac? (
			>=media-plugins/gst-plugins-faad-0.8.8
			>=media-libs/faad2-2.0-r4
		)
	)
	>=media-libs/libid3tag-0.15.0b
	>=media-libs/libvorbis-1.0
	sys-libs/gdbm
	>=gnome-base/gconf-2.0.0
	>=gnome-base/gnome-vfs-2.0.0
	>=x11-libs/gtk+-2.6.0
	>=sys-apps/dbus-0.23.2-r1
	media-libs/flac"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper"

use xine && \
	G2CONF="${G2CONF} --enable-gstreamer=no" || \
	G2CONF="${G2CONF} --enable-gstreamer=yes"


G2CONF="${G2CONF} $(use_enable aac faad2)"

USE_DESTDIR=1
DOCS="AUTHORS COPYING ChangeLog INSTALL \
	  MAINTAINERS NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix the install location of the dbus service file
	sed -i "s:libdir)/dbus-1.0:datadir)/dbus-1:" \
		${S}/data/Makefile.am || die "sed failed"

	epatch ${FILESDIR}/${P}-autoconf.diff || die "epatch failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	gnome2_src_configure "$@"
	emake -j1 || die "compile failure"
}
