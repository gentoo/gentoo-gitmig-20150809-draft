# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mad/gst-plugins-mad-0.8.5.ebuild,v 1.6 2004/11/14 23:50:51 kloeri Exp $

inherit gst-plugins

KEYWORDS="x86 alpha ~amd64 ~hppa ~ia64 ~mips ~ppc sparc"
IUSE=""

RDEPEND=">=media-libs/libmad-0.15.0b
	>=media-libs/libid3tag-0.15"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
