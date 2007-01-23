# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.10.11.ebuild,v 1.3 2007/01/23 14:18:19 gustavoz Exp $

inherit eutils gst-plugins-base

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-1.0.7
	 >=media-libs/gst-plugins-base-0.10.11"
