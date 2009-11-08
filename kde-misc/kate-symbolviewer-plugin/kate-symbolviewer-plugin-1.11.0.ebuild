# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kate-symbolviewer-plugin/kate-symbolviewer-plugin-1.11.0.ebuild,v 1.2 2009/11/08 21:05:31 ssuominen Exp $

ARTS_REQUIRED="never"
EAPI="1"

inherit kde

KDEAPPS_ID="19602"
MY_P="${KDEAPPS_ID}-cppsymbolviewer-${PV}"
S="${WORKDIR}/cppsymbolviewer-${PV}"

DESCRIPTION="Kate Symbol Viewer is a sidebar plugin for Kate."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=${KDEAPPS_ID}"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( kde-base/kate:3.5 kde-base/kdebase:3.5 )"

need-kde 3.5
