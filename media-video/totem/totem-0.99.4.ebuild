# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.99.4.ebuild,v 1.1 2003/09/04 20:07:25 spider Exp $

inherit gnome2

IUSE="gstreamer lirc"
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
	lirc? ( app-misc/lirc )
	!gstreamer? ( >=media-libs/xine-lib-1_beta12 )
	gstreamer? ( >=media-libs/gstreamer-0.6.1
		>=media-libs/gst-plugins-0.6.1 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING*  README* INSTALL NEWS"

# xine is default
use gstreamer && G2CONF="${G2CONF} --enable-gstreamer"
use lirc \
	&& G2CONF="${G2CONF} --enable-lirc" \
	|| G2CONF="${G2CONF} --disable-lirc"


