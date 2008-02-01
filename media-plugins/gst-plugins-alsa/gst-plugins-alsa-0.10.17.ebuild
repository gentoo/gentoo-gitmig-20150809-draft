# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.10.17.ebuild,v 1.1 2008/02/01 12:40:24 drac Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.17
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
