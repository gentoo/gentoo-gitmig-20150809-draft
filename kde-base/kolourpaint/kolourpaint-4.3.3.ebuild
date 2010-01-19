# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.3.3.ebuild,v 1.6 2010/01/19 02:12:24 jer Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
LICENSE="BSD LGPL-2"
IUSE="debug +handbook"

DEPEND="
	kde-base/qimageblitz
"
RDEPEND="${DEPEND}"
