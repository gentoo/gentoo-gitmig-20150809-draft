# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.99.15.1.ebuild,v 1.4 2004/10/30 22:10:48 lv Exp $

inherit gnome2 eutils

DESCRIPTION="Movie player for GNOME"
HOMEPAGE="http://www.hadess.net/totem.php3"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc amd64 ~sparc"
IUSE="gnome gstreamer lirc mad"

RDEPEND=">=dev-libs/glib-2.1
	>=x11-libs/gtk+-2.4
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/libglade-2
	gnome? ( >=gnome-base/libgnomeui-2.4
		>=gnome-base/gnome-desktop-2.2 )
	lirc? ( app-misc/lirc )
	!gstreamer? ( >=media-libs/xine-lib-1_rc5
			>=gnome-base/gconf-2 )
	sparc? ( >=media-libs/xine-lib-1_rc5
		>=gnome-base/gconf-2 )
	!sparc? ( gstreamer? ( =media-libs/gstreamer-0.8*
				=media-libs/gst-plugins-0.8*
				=media-plugins/gst-plugins-gnomevfs-0.8*
				=media-plugins/gst-plugins-xvideo-0.8*
				=media-plugins/gst-plugins-ffmpeg-0.8*
				mad? ( =media-plugins/gst-plugins-mad-0.8* )
				) )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	>=sys-devel/autoconf-2.58"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

# xine is default
use gstreamer && G2CONF="${G2CONF} --enable-gstreamer"

use lirc \
	&& G2CONF="${G2CONF} --enable-lirc" \
	|| G2CONF="${G2CONF} --disable-lirc"

use gnome \
	&& G2CONF="${G2CONF} --disable-gtk" \
	|| G2CONF="${G2CONF} --enable-gtk"

src_unpack() {

	unpack ${A}
	cd ${S}
	# use the omf_fix for scrollkeeper sandbox
	# violations, see bug #48800 <obz@gentoo.org>
	gnome2_omf_fix

}

