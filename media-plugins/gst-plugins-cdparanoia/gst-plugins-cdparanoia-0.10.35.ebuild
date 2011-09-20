# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.35.ebuild,v 1.2 2011/09/20 03:42:50 phajdan.jr Exp $

inherit gst-plugins-base

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-sound/cdparanoia-3.10.2-r3"
DEPEND="${RDEPEND}"
