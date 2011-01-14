# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-data/koffice-data-2.3.0.ebuild,v 1.1 2011/01/14 20:38:15 dilfridge Exp $

EAPI=3

KMNAME="koffice"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Shared KOffice data files"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/lcms:0"
RDEPEND="${DEPEND}"

KMEXTRA="pics/
	servicetypes/
	templates/"
KMEXTRACTONLY="
	KoConfig.h.cmake
	doc/CMakeLists.txt
	doc/koffice.desktop"
