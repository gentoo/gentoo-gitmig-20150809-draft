# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.8.7.ebuild,v 1.8 2005/03/21 01:38:27 kloeri Exp $

inherit eutils gst-plugins

KEYWORDS="x86 alpha amd64 arm hppa ia64 ~mips ppc sparc ~ppc64"
IUSE=""

RDEPEND=">=media-libs/libvorbis-1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
