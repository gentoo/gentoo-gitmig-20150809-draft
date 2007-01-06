# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tapiocaui/tapiocaui-0.3.9.ebuild,v 1.5 2007/01/06 15:40:11 drizzt Exp $

inherit eutils

DESCRIPTION="Tapioca UI"
HOMEPAGE="http://tapioca-voip.sf.net"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
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

# Test is not ready yet, but it's ready enough to crash :]
RESTRICT="test"

pkg_setup() {
	if ! built_with_use media-plugins/gst-plugins-farsight jingle ; then
		eerror "In order to use tapioca core and client, you need to have"
		eerror "media-plugins/gst-plugins-farsight emerged with 'jingle' flags. Please"
		eerror "add that flag, re-emerge gst-plugins-farsight and then tapiocaui"
		die "media-plugins/gst-plugins-farsight is missing jingle"
	fi
	if ! built_with_use media-libs/farsight jingle ; then
		eerror "In order to use tapioca core and client, you need to have"
		eerror "media-libs/farsight emerged with 'jingle' flags. Please"
		eerror "add that flag, re-emerge farsight and then tapiocaui"
		die "media-libs/farsight is missing jingle"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Naive fix due to farsight ABI change.
	epatch "${FILESDIR}/${P}-farsight.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}

pkg_postinst() {
	elog "If you are using kde you need to run"
	elog 'eval `dbus-launch --sh-syntax --exit-with-session`'
	elog "in the same environment where you start tapiocaui later"
}
