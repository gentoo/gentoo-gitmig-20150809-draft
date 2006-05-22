# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tapiocaui/tapiocaui-0.3.0.ebuild,v 1.2 2006/05/22 00:15:21 genstef Exp $

inherit eutils

DESCRIPTION="Tapioca UI"
HOMEPAGE="http://tapioca-voip.sf.net"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

RDEPEND="net-im/tapiocad
	net-im/tapioca-xmpp
	dev-libs/libxml2
	gnome-base/gconf
	gnome-base/libglade
	media-libs/farsight
	media-libs/gstreamer
	>=media-libs/gst-plugins-base-0.10.5
	>=media-libs/gst-plugins-good-0.10.2-r1
	media-plugins/gst-plugins-farsight
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2"

pkg_setup() {
	if ! built_with_use dev-libs/farsight-darcs jingle ; then
		eerror "In order to use tapioca core and client, you need to have"
		eerror "dev-libs/farsight-darcs emerged with 'jingle' flags. Please"
		eerror "add that flag, re-emerge farsight and then tapioca-core-client"
		die "dev-libs/farsight-darcs is missing jingle"
	fi
	if ! built_with_use media-plugins/gst-plugins-farsight jingle ; then
		eerror "In order to use tapioca core and client, you need to have"
		eerror "media-plugins/gst-plugins-farsight emerged with 'jingle' flags. Please"
		eerror "add that flag, re-emerge gst-plugins-farsight and then tapioca-core-client"
		die "media-plugins/gst-plugins-farsight is missing jingle"
	fi
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	einfo "If you are using kde you need to run"
	echo 'eval `dbus-launch --sh-syntax --exit-with-session`'
	einfo "in the same environment where you start tapiocaui later"
}
