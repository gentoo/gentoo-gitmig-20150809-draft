# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mad/gst-plugins-mad-0.8.2.ebuild,v 1.8 2004/08/28 02:38:41 tgall Exp $

inherit gst-plugins

KEYWORDS="x86 ~ppc sparc alpha hppa amd64 ~ia64 ~mips ppc64"

IUSE=""

RDEPEND=">=media-libs/libmad-0.15.0b
	>=media-libs/libid3tag-0.15"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
