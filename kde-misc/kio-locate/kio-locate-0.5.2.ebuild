# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-locate/kio-locate-0.5.2.ebuild,v 1.2 2011/10/29 00:36:39 abcd Exp $

EAPI=4

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Locate KIO slave for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php/kio-locate?content=120965"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/120965-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS=(AUTHORS ChangeLog)

RDEPEND="${RDEPEND}
	sys-apps/mlocate
"
