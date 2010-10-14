# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.21.ebuild,v 1.9 2010/10/14 20:59:37 maekke Exp $

inherit gst-plugins-good

KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.27
	>=media-libs/gstreamer-0.10.27
	>=media-libs/taglib-1.5"
DEPEND="${RDEPEND}"
