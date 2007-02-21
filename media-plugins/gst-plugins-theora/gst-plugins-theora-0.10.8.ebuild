# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.8.ebuild,v 1.8 2007/02/21 12:37:40 uberlord Exp $

inherit gst-plugins-base

KEYWORDS="alpha ~amd64 arm ~hppa ia64 ppc ~ppc64 sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libtheora-1.0_alpha3
	>=media-libs/libogg-1
	>=media-libs/gst-plugins-base-0.10.8"
DEPEND="${RDEPEND}"
