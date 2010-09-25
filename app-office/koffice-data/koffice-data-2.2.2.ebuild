# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-data/koffice-data-2.2.2.ebuild,v 1.1 2010/09/25 20:14:19 dilfridge Exp $

EAPI="2"

KMNAME="koffice"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Shared KOffice data files."

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="media-libs/lcms:0"
RDEPEND="${DEPEND}"

KMEXTRA="pics/
	servicetypes/
	templates/"
KMEXTRACTONLY="
	doc/CMakeLists.txt
	doc/koffice.desktop"
