# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bmpx/bmpx-0.12.9-r2.ebuild,v 1.4 2006/04/23 00:48:25 tcort Exp $

inherit gnome2 autotools eutils

MY_P=${P/_p/-}
MY_P=${MY_P/_rc/_RC}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Next generation Beep Media Player"
HOMEPAGE="http://www.beep-media-player.org/"
SRC_URI="mirror://sourceforge/beepmp/${MY_P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="a52 dbus debug flac irssi mad ogg perl python theora vorbis xchat xine"

RDEPEND=">=dev-libs/glib-2.8.0
	>=x11-libs/gtk+-2.8.0
	>=gnome-base/libglade-2.5.1
	>=x11-libs/pango-1.10.0
	>=dev-libs/libxml2-2.6.18
	>=x11-libs/cairo-1.0.0
	>=x11-libs/startup-notification-0.8
	>=media-libs/taglib-1.4
	dbus? ( >=sys-apps/dbus-0.60 )
	perl? ( dev-lang/perl )
	python? ( dev-lang/python >=dev-python/pygtk-2.8 )
	irssi? ( >=net-irc/irssi-0.8.9 )
	xchat? ( || ( >=net-irc/xchat-2.4.1 >=net-irc/xchat-gnome-0.6 ) )
	virtual/fam
	net-misc/curl
	>=media-libs/xine-lib-1.0.1"
# gstreamer support is on hold until gstreamer 0.9
#	xine? ( >=media-libs/xine-lib-1.0.1 )
#	!xine? ( >=media-libs/gstreamer-0.8.9-r3
#		>=media-libs/gst-plugins-0.8.8
#		>=media-plugins/gst-plugins-pango-0.8.8
#		mad? ( >=media-plugins/gst-plugins-mad-0.8.8 )
#		ogg? ( >=media-plugins/gst-plugins-ogg-0.8.8 )
#		vorbis? ( >=media-plugins/gst-plugins-ogg-0.8.8
#			>=media-plugins/gst-plugins-vorbis-0.8.8 )
#		a52? ( >=media-plugins/gst-plugins-a52dec-0.8.8 )
#		flac? ( >=media-plugins/gst-plugins-flac-0.8.8 )
#		theora? ( >=media-plugins/gst-plugins-ogg-0.8.8
#		        >=media-plugins/gst-plugins-theora-0.8.8 )
#		)"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog NEWS README"

# gstreamer is default backend
G2CONF="${G2CONF} \
	$(use_enable dbus) \
	$(use_enable perl) \
	$(use_enable python) \
	$(use_enable irssi) \
	$(use_enable xchat)"
#useq xine || G2CONF="${G2CONF} --enable-gst"

USE_DESTDIR="1"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-libtoolize-static-libs.patch
	epatch ${FILESDIR}/${P}-old-config-crash.patch
	epatch ${FILESDIR}/${P}-no-config.patch
	epatch ${FILESDIR}/${P}-dbus-fix.patch

	AT_M4DIR="-I m4" \
	eautoreconf
}

src_install() {
	gnome2_src_install

	insinto /usr/share/bmpx/skins/gentoo_ice
	doins ${WORKDIR}/gentoo_ice/*
	docinto gentoo_ice
	dodoc ${WORKDIR}/README
}

pkg_postinst() {
	gnome2_pkg_postinst

	if useq irssi || useq xchat ; then
		ewarn "To use the Perl Irssi/XChat scripts, please do:"
		echo
		ewarn "  # emerge app-portage/g-cpan"
		ewarn "  # g-cpan -i Net::DBus"
		echo
		ebeep
	fi
}
