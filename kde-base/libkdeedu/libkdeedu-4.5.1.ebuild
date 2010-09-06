# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.5.1.ebuild,v 1.1 2010/09/06 01:39:51 tampakrap Exp $

EAPI="3"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS=""
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.2.87
RESTRICT=test

src_install() {
	kde4-meta_src_install
	# This is installed by kde-base/marble
	rm "${ED}"/${KDEDIR}/share/apps/cmake/modules/FindMarbleWidget.cmake
}
