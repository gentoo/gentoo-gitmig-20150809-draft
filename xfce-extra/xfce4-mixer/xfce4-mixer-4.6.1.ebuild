# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.6.1.ebuild,v 1.11 2009/10/08 17:37:08 darkside Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Volume control application using gstreamer"
HOMEPAGE="http://www.xfce.org/projects/xfce4-mixer"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="alsa debug oss"

COMMON_DEPEND=">=dev-libs/glib-2.12:2
	>=media-libs/gst-plugins-base-0.10.14
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfce4-panel-4.6
	>=xfce-base/xfconf-4.6"
RDEPEND="${COMMON_DEPEND}
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10 )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}
