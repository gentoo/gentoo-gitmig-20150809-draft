# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-2.6.0.3.ebuild,v 1.2 2004/04/05 20:42:58 lu_zero Exp $

# FIXME : double check all the acme stuff
inherit gnome2 eutils

DESCRIPTION="The gnome2 Desktop configuration tool"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"
IUSE="alsa gstreamer"

MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND=">=x11-libs/gtk+-2.3
	virtual/xft
	media-libs/fontconfig
	>=dev-libs/atk-1.2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2.2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/nautilus-2.2
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/gnome-desktop-2.2
	dev-libs/libxml2
	media-sound/esound
	>=x11-wm/metacity-2.4.5
	>=x11-libs/libxklavier-1
	alsa? ( >=media-libs/alsa-lib-0.9 )
	gstreamer? ( >=media-libs/gst-plugins-0.8 )
	!gnome-extra/fontilus
	!gnome-extra/themus
	!gnome-extra/acme"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog COPYING README TODO INSTALL NEWS"

G2CONF="${G2CONF} \
	--disable-schemas-install\
	--enable-vfs-methods \
	$(use_enable alsa) \
	$(use_enable gstreamer)"

USE_DESTDIR="1"

src_unpack() {

	unpack ${A}
	cd ${S}

	# See http://gcc.gnu.org/cgi-bin/gnatsweb.pl problem #9700 for
	# what this is about.
	use alpha && epatch ${FILESDIR}/control-center-2.2.0.1-alpha_hack.patch

	# Temporary workaround for a problematic behaviour with acme.
	epatch ${FILESDIR}/control-center-2.6.0-remove-pmu.patch
	# temporary fix for icon installation adapted by <link@sub_pop.net> (#16928)
	# FIXME : this broke again
#	epatch ${FILESDIR}/${PN}-2.2-icons_install.patch

}
