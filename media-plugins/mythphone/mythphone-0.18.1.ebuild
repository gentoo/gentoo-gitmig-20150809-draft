# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.18.1.ebuild,v 1.2 2005/05/31 14:56:36 dholm Exp $

inherit mythtv-plugins

DESCRIPTION="Phone and video calls with SIP."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"
IUSE="festival"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="~media-tv/mythtv-${PV}
	festival? ( app-accessibility/festival )"

MTVCONF=$(use_enable festival)
