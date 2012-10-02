# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/obs-service-download_files/obs-service-download_files-9999.ebuild,v 1.3 2012/10/02 11:06:53 scarabeus Exp $

EAPI=4

inherit obs-service

IUSE=""
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}
	net-misc/wget
"
