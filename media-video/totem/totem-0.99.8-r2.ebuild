# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.99.8-r2.ebuild,v 1.4 2004/02/09 00:02:13 vapier Exp $

inherit gnome2

DESCRIPTION="Movie player for GNOME"
HOMEPAGE="http://www.hadess.net/totem.php3"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="gstreamer lirc curl"

# specific gtk dep is needed for a certain xfree patch (#21336)
RDEPEND=">=dev-libs/glib-2.1
	>=x11-libs/gtk+-2.2.2-r1
	>=gnome-base/libgnomeui-2.1.1
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2.2
	lirc? ( app-misc/lirc )
	!gstreamer? ( >=media-libs/xine-lib-1_rc0
		curl? ( >=net-ftp/curl-7.9.8 )
	)
	gstreamer? ( >=media-libs/gstreamer-0.6.3
		>=media-libs/gst-plugins-0.6.3
		>=media-plugins/gst-plugins-gnomevfs-0.6.3
		>=media-plugins/gst-plugins-colorspace-0.6.3
		>=media-plugins/gst-plugins-xvideo-0.6.3
		mad? ( >=media-plugins/gst-plugins-mad-0.6.3 )
		)"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0
	>=sys-devel/autoconf-2.58"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# add enable/disable curl
	epatch ${FILESDIR}/${P}-curl.patch

	# Disables a videodriver that doesn't work with all nvidia drivers
	# you can override it by putting xvmc in ~/.gnome2/totem_config
	epatch ${FILESDIR}/${P}-nvidia.patch
	export WANT_AUTOCONF=2.5
	autoconf

	#fixes sandbox violations
	gnome2_omf_fix
}


# move this in the right order so stacking works. "fulhack"
use curl \
	&& G2CONF="${G2CONF} --enable-curl" \
	|| G2CONF="${G2CONF} --disable-curl"

# xine is default
use gstreamer && G2CONF="${G2CONF} --enable-gstreamer --disable-curl"

use lirc \
	&& G2CONF="${G2CONF} --enable-lirc" \
	|| G2CONF="${G2CONF} --disable-lirc"
