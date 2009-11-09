# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krunner-kopete-contacts/krunner-kopete-contacts-0.3.ebuild,v 1.1 2009/11/09 13:58:27 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A krunner plug-in that allows you to open conversation with your contact"
HOMEPAGE="http://www.kde-apps.org/content/show.php?action=content&content=105263"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/105263-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkworkspace-${KDE_MINIMAL}
	>=kde-base/kopete-${KDE_MINIMAL}"

DOCS="README"
