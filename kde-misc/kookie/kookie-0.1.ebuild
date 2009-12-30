# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kookie/kookie-0.1.ebuild,v 1.1 2009/12/30 23:28:22 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A program to manage recipes and shopping lists"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Kookie?content=117806 http://gitorious.org/kookie"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/117806-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}
