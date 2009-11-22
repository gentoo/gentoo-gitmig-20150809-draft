# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.24.ebuild,v 1.7 2009/11/22 18:50:25 klausman Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
