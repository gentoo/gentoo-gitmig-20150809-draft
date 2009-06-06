# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kweather/kweather-3.5.10.ebuild,v 1.4 2009/06/06 10:51:35 maekke Exp $

KMNAME=kdetoys
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE weather status display"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=""

PATCHES="${FILESDIR}/kweather-3.5.9-gcc-4.3.patch"
