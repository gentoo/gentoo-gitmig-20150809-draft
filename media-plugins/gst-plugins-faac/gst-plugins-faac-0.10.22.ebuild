# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.22.ebuild,v 1.6 2012/10/21 08:57:31 maekke Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~arm ppc ppc64 x86"
IUSE=""

RDEPEND="media-libs/faac
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"
