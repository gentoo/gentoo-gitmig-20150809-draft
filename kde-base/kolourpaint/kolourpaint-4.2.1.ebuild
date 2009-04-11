# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.2.1.ebuild,v 1.3 2009/04/11 17:33:21 armin76 Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"
LICENSE="BSD LGPL-2"

DEPEND="
	kde-base/qimageblitz
"
RDEPEND="${DEPEND}"
