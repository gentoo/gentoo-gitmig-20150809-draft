# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mad/gst-plugins-mad-0.8.5.ebuild,v 1.10 2005/01/12 17:02:46 gmsoft Exp $

inherit gst-plugins

KEYWORDS="x86 alpha amd64 hppa ~ia64 ~mips ppc ~ppc64 sparc"
IUSE=""

RDEPEND=">=media-libs/libmad-0.15.0b
	>=media-libs/libid3tag-0.15"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
