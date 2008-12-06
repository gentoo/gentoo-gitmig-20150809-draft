# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.21.ebuild,v 1.2 2008/12/06 01:51:13 solar Exp $

inherit gst-plugins-base

KEYWORDS="~arm ~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.21
	>=dev-libs/glib-2.15.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
