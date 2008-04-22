# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-suspendoutput/vdr-suspendoutput-0.2.5.ebuild,v 1.2 2008/04/22 16:00:32 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Show still image instead of live tv to safe cpu"
HOMEPAGE="http://phivdr.dyndns.org/vdr/vdr-suspendoutput/"
SRC_URI="http://phivdr.dyndns.org/vdr/vdr-suspendoutput/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr"
RDEPEND="${DEPEND}"
