# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/downloadmanager/downloadmanager-0.1.2.ebuild,v 1.2 2006/10/04 15:04:26 lack Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="DownloadManager"
DESCRIPTION="Download Manager - a downloader for the Fetch and the ROX Desktop"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/downloadmanager.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=rox-extra/fetch-0.1.0
	>=sys-apps/dbus-0.22"

APPNAME=${MY_PN}
S=${WORKDIR}
