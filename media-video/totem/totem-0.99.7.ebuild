# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.99.7.ebuild,v 1.2 2004/03/29 01:04:53 vapier Exp $

inherit gnome2

IUSE="gstreamer lirc curl"
DESCRIPTION="Movie player for GNOME"
HOMEPAGE="http://www.hadess.net/totem.php3"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

# specific gtk dep is needed for a certain xfree patch (#21336)
RDEPEND=">=dev-libs/glib-2.1
	>=x11-libs/gtk+-2.2.2-r1
	>=gnome-base/libgnomeui-2.1.1
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2.2
	curl? ( >=net-misc/curl-7.9.8 )
	lirc? ( app-misc/lirc )
	!gstreamer? ( >=media-libs/xine-lib-1_rc0 )
	gstreamer? ( >=media-libs/gstreamer-0.6.3
		>=media-libs/gst-plugins-0.6.3
		>=media-plugins/gst-plugins-gnomevfs-0.6.3
		>=media-plugins/gst-plugins-colorspace-0.6.3
		>=media-plugins/gst-plugins-xvideo-0.6.3
		mad? ( >=media-plugins/gst-plugins-mad-0.6.3 )
		)"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

# xine is default
use gstreamer && G2CONF="${G2CONF} --enable-gstreamer"

use lirc \
	&& G2CONF="${G2CONF} --enable-lirc" \
	|| G2CONF="${G2CONF} --disable-lirc"


