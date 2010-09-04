# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-theora/gst-plugins-theora-0.10.28.ebuild,v 1.8 2010/09/04 11:53:00 armin76 Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libtheora-1.0
	media-libs/libogg"
DEPEND="${RDEPEND}"
