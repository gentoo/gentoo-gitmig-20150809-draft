# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.10.31.ebuild,v 1.5 2011/02/27 15:31:37 ranger Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libvorbis-1.0
	>=media-libs/libogg-1.0"
DEPEND="${RDEPEND}"
