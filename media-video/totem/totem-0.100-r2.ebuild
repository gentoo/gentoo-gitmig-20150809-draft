# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.100-r2.ebuild,v 1.4 2005/01/30 10:18:00 lanius Exp $

inherit gnome2 eutils

DESCRIPTION="Media player for GNOME"
HOMEPAGE="http://www.hadess.net/totem.php3"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 ~sparc"
IUSE="gstreamer lirc mad debug"

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.4
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.4
	<gnome-extra/nautilus-cd-burner-2.9
	>=gnome-base/gnome-desktop-2.2
	lirc? ( app-misc/lirc )
	!gstreamer? ( >=media-libs/xine-lib-1_rc7
			>=gnome-base/gconf-2 )
	sparc? ( >=media-libs/xine-lib-1_rc7
		>=gnome-base/gconf-2 )
	!sparc? ( gstreamer? ( >=media-libs/gstreamer-0.8.7
				>=media-libs/gst-plugins-0.8.5
				>=media-plugins/gst-plugins-gnomevfs-0.8.5
				>=media-plugins/gst-plugins-xvideo-0.8.5
				=media-plugins/gst-plugins-ffmpeg-0.8.3
				mad? ( >=media-plugins/gst-plugins-mad-0.8.5 )
				) )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	sys-devel/automake"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

# xine is default for now
use gstreamer && G2CONF="${G2CONF} --enable-gstreamer"

# gtk only support broken
#use gnome \
#	&& G2CONF="${G2CONF} --disable-gtk" \
#	|| G2CONF="${G2CONF} --enable-gtk"

G2CONF="${G2CONF} \
	$(use_enable lirc) \
	$(use_enable debug) \
	--disable-gtk \
	--disable-mozilla"

src_unpack() {

	unpack ${A}

	cd ${S}
	# use the omf_fix for scrollkeeper sandbox
	# violations, see bug #48800 <obz@gentoo.org>
	gnome2_omf_fix

	# order the cdrom include (#68087)
	epatch ${FILESDIR}/${P}-cdrom_include.patch
	# fix the desktop item (#77204)
	epatch ${FILESDIR}/${P}-fix_desktop_item.patch
	# some more minor fixes
	cd ${S}/src
	epatch ${FILESDIR}/${P}-gst_backend_fixes-r1.patch

	WANT_AUTOMAKE=1.4 automake

}

USE_DESTDIR="1"
