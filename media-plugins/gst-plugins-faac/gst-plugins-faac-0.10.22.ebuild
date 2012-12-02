# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.22.ebuild,v 1.7 2012/12/02 16:09:16 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~arm ppc ppc64 x86"
IUSE=""

RDEPEND="media-libs/faac
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"
