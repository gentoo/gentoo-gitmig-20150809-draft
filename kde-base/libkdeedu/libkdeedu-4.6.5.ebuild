# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.6.5.ebuild,v 1.4 2011/08/15 22:00:50 maekke Exp $

EAPI=4

KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdeedu"
	KMEXTRACTONLY="libkdeedu/libscience kalzium"
	KMEXTRA="kalzium/libscience"
	kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.6.1. Tests are fundamentally broken,
# see bug 258857 for details.
RESTRICT=test

add_blocker kvtml-data
