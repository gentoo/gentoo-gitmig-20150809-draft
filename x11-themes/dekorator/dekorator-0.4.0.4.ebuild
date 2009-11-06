# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/dekorator/dekorator-0.4.0.4.ebuild,v 1.1 2009/11/06 19:54:27 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A window decoration engine for KDE4"
HOMEPAGE="http://www.kde-look.org/content/show.php/Nitrogen?content=87921"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/87921-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/kwin-${KDE_MINIMAL}"

DOCS="AUTHORS ChangeLog CHANGELOG.original README README.original TODO"
