# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.10.24.ebuild,v 1.6 2009/11/22 18:51:46 klausman Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.23
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
