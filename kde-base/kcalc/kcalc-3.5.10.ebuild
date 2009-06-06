# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcalc/kcalc-3.5.10.ebuild,v 1.4 2009/06/06 10:53:15 maekke Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE Calculator"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="dev-libs/gmp"
