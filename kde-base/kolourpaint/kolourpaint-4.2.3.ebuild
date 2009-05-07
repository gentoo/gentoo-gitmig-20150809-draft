# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.2.3.ebuild,v 1.1 2009/05/06 23:42:18 scarabeus Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
LICENSE="BSD LGPL-2"
IUSE="debug doc"

DEPEND="
	kde-base/qimageblitz
"
RDEPEND="${DEPEND}"
