# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-download_files/obs-service-download_files-9999.ebuild,v 1.1 2011/11/16 15:48:44 miska Exp $

EAPI=4

if [[ "${PV}" != "9999" ]]; then
	OPENSUSE_RELEASE="12.1"
	KEYWORDS="~amd64 ~x86"
fi

inherit obs-service

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	net-misc/wget
"
