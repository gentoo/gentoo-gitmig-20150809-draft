# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/downloadmanager/downloadmanager-0.1.2-r1.ebuild,v 1.4 2006/12/02 22:03:24 cardoe Exp $

ROX_LIB_VER=2.0.0
inherit rox eutils

MY_PN="DownloadManager"
DESCRIPTION="Download Manager - a downloader for the Fetch and the ROX Desktop"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/downloadmanager.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=rox-extra/fetch-0.1.0
	|| ( >=dev-python/dbus-python-0.71
		( >=sys-apps/dbus-0.3 <sys-apps/dbus-0.90 ) )"

APPNAME=${MY_PN}
S=${WORKDIR}

pkg_setup() {
	if ! has_version dev-python/dbus-python && \
		! built_with_use sys-apps/dbus python
	then
		einfo "${APPNAME} requires dbus to be built with python support."
		einfo "Please rebuild dbus with USE=\"python\"."
		die "python dbus modules missing"
	fi
}

