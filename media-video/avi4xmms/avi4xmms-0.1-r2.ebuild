# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/avi4xmms/avi4xmms-0.1-r2.ebuild,v 1.1 2002/08/23 12:36:13 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A plugin for XMMS to play AVI/DivX/ASF movies"
SRC_URI=""
HOMEPAGE="http://sourceforge.net/projects/my-xmms-plugs/"

RDEPEND="media-video/avi-xmms"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

pkg_postinst() {

	einfo "No longer is XMMS required to be compiled against avifile"
	einfo "This ebuild is now a wrapper for avi-xmms, which has been"
	einfo "resurrected to work with most avi types"
}
