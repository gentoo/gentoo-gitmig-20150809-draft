# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ttxtsubs/vdr-ttxtsubs-0.1.0.ebuild,v 1.2 2009/06/03 15:35:38 mr_bones_ Exp $

EAPI="2"

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: displaying, recording and replaying teletext
based subtitles"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-ttxtsubs"
SRC_URI="http://projects.vdr-developer.org/attachments/download/96/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0[ttxtsubs]"
RDEPEND="${DEPEND}"
