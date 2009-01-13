# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.1.4.ebuild,v 1.1 2009/01/13 22:30:45 alexxy Exp $

EAPI="2"

KMNAME=kdegraphics
inherit kde4-meta eutils

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"
LICENSE="BSD LGPL-2"

DEPEND="kde-base/qimageblitz"
RDEPEND="${DEPEND}"
