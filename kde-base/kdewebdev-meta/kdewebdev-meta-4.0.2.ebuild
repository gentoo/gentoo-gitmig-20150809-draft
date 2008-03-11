# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev-meta/kdewebdev-meta-4.0.2.ebuild,v 1.1 2008/03/11 00:05:47 philantrop Exp $

EAPI="1"

inherit kde4-functions

DESCRIPTION="KDE web development - Quanta"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
SLOT="kde-4"
IUSE="tidy"

DEPEND="
	tidy? ( app-text/htmltidy )"

RDEPEND="
		>=kde-base/kfilereplace-${PV}:${SLOT}
		>=kde-base/kimagemapeditor-${PV}:${SLOT}
		>=kde-base/klinkstatus-${PV}:${SLOT}
"
