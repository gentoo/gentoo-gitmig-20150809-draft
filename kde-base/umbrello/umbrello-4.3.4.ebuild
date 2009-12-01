# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.3.4.ebuild,v 1.1 2009/12/01 11:36:37 wired Exp $

EAPI="2"

KMNAME="kdesdk"

inherit kde4-meta

DESCRIPTION="KDE UML Modeller"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND="
	dev-libs/boost
	dev-libs/libxml2
	dev-libs/libxslt
"
RDEPEND="${DEPEND}"
