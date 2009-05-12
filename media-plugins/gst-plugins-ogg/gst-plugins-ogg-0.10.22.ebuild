# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.22.ebuild,v 1.3 2009/05/12 20:27:00 fauli Exp $

inherit gst-plugins-base

KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-libs/libogg-1.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
