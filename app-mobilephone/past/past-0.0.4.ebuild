# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/past/past-0.0.4.ebuild,v 1.1 2009/11/11 17:53:35 ssuominen Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="A simple SMS tool"
HOMEPAGE="http://www.kde-apps.org/content/show.php/past+-+SMS+Tool?content=74036"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/74036-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	app-mobilephone/gnokii[sms]"

DOCS="ChangeLog README TODO"
