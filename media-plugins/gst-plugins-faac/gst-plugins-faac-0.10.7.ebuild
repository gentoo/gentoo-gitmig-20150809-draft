# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.7.ebuild,v 1.6 2008/08/07 21:23:44 klausman Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/faac
	>=media-libs/gst-plugins-base-0.10.17
	>=media-libs/gstreamer-0.10.17"

DEPEND="${RDEPEND}"
