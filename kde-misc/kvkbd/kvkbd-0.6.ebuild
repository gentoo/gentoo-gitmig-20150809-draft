# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kvkbd/kvkbd-0.6.ebuild,v 1.1 2009/09/01 18:17:39 patrick Exp $

EAPI="2"

inherit kde4-base

KDEAPPS_ID="94374"

DESCRIPTION="A virtual keyboard for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=94374"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${KDEAPPS_ID}-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
