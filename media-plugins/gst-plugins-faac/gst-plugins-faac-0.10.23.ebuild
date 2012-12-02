# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.23.ebuild,v 1.1 2012/12/02 17:55:40 eva Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/faac"
DEPEND="${RDEPEND}"
