# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mad/gst-plugins-mad-0.8.0.ebuild,v 1.1 2004/03/28 19:47:32 foser Exp $

inherit gst-plugins

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"

IUSE=""

RDEPEND=">=media-libs/libmad-0.15
	>=media-libs/libid3tag-0.15"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
