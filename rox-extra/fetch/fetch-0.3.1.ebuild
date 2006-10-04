# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/fetch/fetch-0.3.1.ebuild,v 1.2 2006/10/04 15:09:01 lack Exp $

ROX_VER=2.1.2
ROX_LIB_VER=2.0.2
inherit rox eutils

MY_PN="Fetch"
DESCRIPTION="Fetch - a downloader for the ROX Desktop"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/fetch.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

APPNAME=Fetch
S=${WORKDIR}

pkg_postinst() {
	rox_pkg_postinst
	if ! built_with_use sys-apps/dbus python
	then
		ewarn "dbus python modules are NOT installed. ${APPNAME} will run"
		ewarn "however, integration with the Download Manager module will"
		ewarn "be possible and the program will crash if you try and set"
		ewarn "that option. If integration with the Download Manager is"
		ewarn "desired, please emerge dbus and then Download Manager and"
		ewarn "then ${APPNAME} should work fine!"
	fi
}

