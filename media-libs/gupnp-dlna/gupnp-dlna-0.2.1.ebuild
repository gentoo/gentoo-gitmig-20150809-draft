# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gupnp-dlna/gupnp-dlna-0.2.1.ebuild,v 1.1 2010/07/21 10:19:55 ford_prefect Exp $

EAPI=3

inherit gnome2

DESCRIPTION="Library that provides DLNA-related functionality for MediaServers"
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/libxml2-2.5.0
	>=media-libs/gstreamer-0.10.30
	>=media-libs/gst-plugins-base-0.10.25"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
