# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-a52dec/gst-plugins-a52dec-0.10.12.ebuild,v 1.9 2010/01/05 18:27:15 nixnut Exp $

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/a52dec-0.7.3
	>=media-libs/gst-plugins-base-0.10.23
	>=media-libs/gstreamer-0.10.23"
