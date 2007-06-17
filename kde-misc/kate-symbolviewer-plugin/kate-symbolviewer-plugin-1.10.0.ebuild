# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kate-symbolviewer-plugin/kate-symbolviewer-plugin-1.10.0.ebuild,v 1.1 2007/06/17 09:15:39 philantrop Exp $

inherit kde

KDEAPPS_ID="19602"
MY_PN=${PN/kate-}
MY_PN=${MY_PN/-plugin/}

DESCRIPTION="Kate Symbol Viewer is a sidebar plugin for Kate."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=${KDEAPPS_ID}"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${KDEAPPS_ID}-${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.5

DEPEND="|| ( kde-base/kate kde-base/kdebase )"
RDEPEND="${DEPEND}"

MY_PN_DIR="cpp${MY_PN}"
S=${WORKDIR}/${MY_PN_DIR}-${PV}
