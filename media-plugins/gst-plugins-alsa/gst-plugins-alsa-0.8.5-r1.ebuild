# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-alsa/gst-plugins-alsa-0.8.5-r1.ebuild,v 1.5 2005/01/12 16:59:13 gmsoft Exp $

inherit eutils gst-plugins

KEYWORDS="x86 ~ppc ~amd64 ~ia64 ~mips hppa ~ppc64 ~sparc"
IUSE=""

DEPEND=">=media-libs/alsa-lib-1.0.7"

src_unpack() {

	gst-plugins_src_unpack

	epatch ${FILESDIR}/${P}-cvs_fixes.patch

}
