# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.2.2.ebuild,v 1.1 2009/04/12 06:25:30 alexxy Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

src_install() {
	kde4-meta_src_install
	# This is installed by kde-base/marble
	rm "${D}"/"${KDEDIR}"/share/apps/cmake/modules/FindMarbleWidget.cmake
}
