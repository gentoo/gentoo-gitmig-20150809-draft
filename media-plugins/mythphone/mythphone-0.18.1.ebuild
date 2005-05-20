# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythphone/mythphone-0.18.1.ebuild,v 1.1 2005/05/20 09:09:15 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Phone and video calls with SIP."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"
IUSE="festival"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="~media-tv/mythtv-${PV}
	festival? ( app-accessibility/festival )"

MTVCONF=$(use_enable festival)
